{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses, ScopedTypeVariables, LambdaCase, InstanceSigs, FlexibleContexts #-}
-- @
--
--      site/ ... name.page
--
--      _make/contents/name.md
-- @

import Development.Shake hiding (getDirectoryContents)
import Development.Shake.FilePath

import System.Directory hiding (doesFileExist)
import qualified System.Directory as Directory
import System.Environment
import Control.Monad
import qualified Control.Exception as E
import Control.Arrow
import Control.Applicative hiding ((*>))
import Data.List
import Data.Maybe
import Data.Char
import Debug.Trace
import Data.Time.LocalTime
import Data.Time.Clock
import Data.Time.Format
import System.Locale

import Text.BibTeX.Entry
import Text.BibTeX.Format
import Text.BibTeX.Parse

import BibTeX

import System.Process
import System.Exit

import Data.Monoid

main = do
        args <- getArgs
        main2 args

main2 ("build":extra) = do

    bib <- fmap (fmap (\ cite -> (tagToFileName $ getBibTexCitationTag cite,cite)))
         $ readBibTeX "_meta/bibtex.bib"

--    liftIO $ print bib

    shake shakeOptions { shakeVerbosity = Normal
--                       , shakeReport = return "shake.html"
                       , shakeThreads = 16
                       } $ do

        want $ [ "_data/publications.yml" ]++
               [ "papers/" ++ nm ++ ".md" | (nm,_) <- bib ]

        addBibTeXOracle "_meta/bibtex.bib" bib
        
        let okayBib xs = not (xs `elem` words "abstract url xurl xxurl xcontent xredirect")

        "_data/publications.yml" *> \ out -> do
	    txt <- sequence 
	    	    [ do md <- readFile' $ "_auto/bibtex/" ++ nm ++ ".md-citation"
			 return $ unlines $ 
			  [ "- key: " ++ nm  ] ++
			  [ "  cite: |" ] ++
			  [ "    " ++ d | d <- lines md, not (all isSpace d) ] ++
			  [ "  a_cite: |" ] ++
			  [ "    " ++ d | d <- id $ lines
                                                  $ replace "\8220" "\8220["
                                                  $ replace ",\8221" ("](/papers/" ++ nm ++ "),\8221")
                                                  $ replace "!\8221" ("!](/papers/" ++ nm ++ ")\8221")
                                                  $ replace "?\8221" ("?](/papers/" ++ nm ++ ")\8221")
                                                  $ md
                                        , not (all isSpace d) ] ++
			  [ "  year: " ++ year | year <- maybeToList $ lookupBibTexCitation "year" e ] ++
			  [ "  links:" ] ++
			  [ "    - <" ++ x ++ ">"| t <- ["url","xurl","xxurl"]
                                        , x <- maybeToList $ lookupBibTexCitation t e 
                                        ] ++
			  [ "  abstract: |" | _ <- maybeToList $ lookupBibTexCitation "abstract" e ] ++
			  [ "    " ++ dropWhile isSpace txt 
                                          | abstract <- maybeToList $ lookupBibTexCitation "abstract" e
                                          , txt <- lines $ unparen "\\emph{" "}"                                          
                                                         $ unparen "{\\em " "}"                                          
                                                         $ replace "{\\textquoteright}" "'"
                                                         $ abstract 
                                          ] ++
			  [ "  bibtex: |"] ++
			  [ "    " ++ txt | txt <- lines $ asciiBibText $ filterBibTexCitation okayBib e ] ++
			  [ "  xcontent: |" | _ <- maybeToList $ lookupBibTexCitation "xcontent" e ] ++
			  [ "    " ++ dropWhile isSpace txt 
                                          | xcontent <- maybeToList $ lookupBibTexCitation "xcontent" e
                                          , txt <- lines xcontent 
                                          ]
	    	    | (nm,e) <- bib
		    ]
            writeFile' out $ unlines $ ("# auto generated from _meta/bibtex.bib" : txt)

------------------------------------------------------------------------------------------------------------------------------

        "papers/*.md" *> \ out -> do
               let nm = (dropExtension (dropDirectory1 out))
               cite <- getBibTeXCitation nm
               writeFile' out $ unlines $
                              [ "---"
                              , "layout: publication"
                              , "key: " ++ nm
                              ]
                              ++ [ "redirect_from:" | _ <- maybeToList $ lookupBibTexCitation "xredirect" cite ]
                              ++ [ " - " ++ txt | txt <- maybeToList $ lookupBibTexCitation "xredirect" cite ]
                              ++ ["---"]


------------------------------------------------------------------------------------------------------------------------------

        "_auto/bibtex/*.bib" *> \ out -> do
                cite <- getBibTeXCitation (dropExtension (dropDirectory1 (dropDirectory1 out)))
		let p xs = not (xs `elem` words "url xurl isbn doi acmid")
                writeFile' out $ asciiBibText $ filterBibTexCitation p $ cite
        

        "_auto/bibtex/*.abstract" *> \ out -> do
                cite <- getBibTeXCitation (dropExtension (dropDirectory1 (dropDirectory1 out)))
                case lookupBibTexCitation "abstract" cite of
                   Just abs_txt -> writeFile' out abs_txt
                   Nothing -> writeFile' out "No Abstract in BiBTeX"
		   		 -- TODO: use  return ()

        "_auto/bibtex/*.aux" *> \ out -> do
                cite <- getBibTeXCitation (dropExtension (dropDirectory1 (dropDirectory1 out)))
                writeFile' out $ unlines
                        [ "% generated"
                        , "\\bibstyle{IEEEtran}"
                        , "\\citation{" ++ getBibTexCitationTag cite ++ "}"
                        , "\\bibdata{" ++ dropExtension (takeFileName out) ++ "}"
                        ]

        "_auto/bibtex/*.bbl" *> \ out -> do
                need [ replaceExtension out ".bib"
                     , replaceExtension out ".aux"
                        -- TODO: also the bst file???
                     ]
                cmd (Cwd $ dropFileName out) "bibtex" [dropExtension (takeFileName out)]

		-- Short has the preamble to postamble removed
        "_auto/bibtex/*.bbl-short" *> \ out -> do
                txt <- readFile' (replaceExtension out "bbl")
                let macros xs | "\\doi{" `isPrefixOf` xs = "doi: \\texttt{" ++ macros (drop 5 xs)
                    macros (x:xs) = x : macros xs
                    macros [] = []
                writeFile' out $ remove "\\hskip" "\\relax"
                               $ unlines
                               $ map macros
                               $ takeWhile (not . all isSpace)                  -- take until first blank line
                               $ dropWhile (\ x -> length (takeWhile isSpace x) > 0)
                               $ tail                                           -- and the bibitem line
                               $ dropWhile (not . ("\\bibitem" `isPrefixOf`))   -- drop preamble
                               $ lines
                               $ txt

        "_auto/bibtex/*.md-citation" *> \ out -> do
                -- If this crashes, check to see if you have pandoc
                need [ replaceExtension out "bbl-short"
                     ]
                -- outputs single paragraph
                txt <- liftIO $ readProcess "pandoc" 
			    [ "-f","latex"
                            , "-t", "markdown"
                            , replaceExtension out "bbl-short"
                            ]
			    ""
		let lnk = dropExtension (dropDirectory1 (dropDirectory1 out))
		writeFile' out 
			   $ replace "\160" " "
			   $ txt	    

        "_auto/bibtex/*.html-abstract" *> \ out -> do
                need [ replaceExtension out "abstract"
                     ]
                cmd    "pandoc" ["-f","latex",
                                 "-t", "markdown",
                                 replaceExtension out "abstract",
                                 "-o", out ]



main2 ["clean"] = do
        system "rm -Rf _auto"
        system "rm _data/publications.yml"
        return ()


main2 _ = putStrLn $ unlines
        [ "usage:"
        , "./Main clean    clean up"
        , "       build    build autogenerated pages"
        ]

-- The reg package messed up because of LANG=....8. See 
-- http://stackoverflow.com/questions/5047626/matching-specific-unicode-char-in-haskell-regexp 
-- for details.

replace :: String -> String -> String -> String
replace re new inp | re `isPrefixOf` inp = new ++ replace re new (drop (length re) inp)
replace re new (c:cs) = c : replace re new cs
replace re new [] = []

remove :: String -> String -> String -> String
remove start end inp = outside inp
   where
           outside cs | start `isPrefixOf` cs = inside (drop (length start) cs)
           outside (c:cs) = c : outside cs
           outside [] = []

           inside cs | end `isPrefixOf` cs = outside (drop (length end) cs)
           inside (c:cs) = inside cs
           inside [] = []

unparen :: String -> String -> String -> String
unparen start end inp = outside inp
   where
           outside cs | start `isPrefixOf` cs = inside (drop (length start) cs)
           outside (c:cs) = c : outside cs
           outside [] = []

           inside cs | end `isPrefixOf` cs = outside (drop (length end) cs)
           inside (c:cs) = c : inside cs
           inside [] = []
