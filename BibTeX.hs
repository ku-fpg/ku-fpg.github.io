{-# LANGUAGE FlexibleInstances, GeneralizedNewtypeDeriving, DeriveDataTypeable, MultiParamTypeClasses, ScopedTypeVariables, LambdaCase, InstanceSigs, FlexibleContexts, TypeFamilies #-}

module BibTeX
        ( FindBibTeX
        , addBibTeXOracle
        , getBibTeXCitation
        , BibTeXCitation                -- abstract
        , readBibTeX
        , asciiBibText
        , lookupBibTexCitation
        , filterBibTexCitation
        , getBibTexCitationTag
        , tagToFileName
) where

import qualified Text.BibTeX.Entry as B
import qualified Text.BibTeX.Parse as P
import qualified Text.BibTeX.Format as F
import qualified Text.Parsec as Parsec


import Data.Monoid
import Data.Hashable
import Data.Binary

import Development.Shake hiding (getDirectoryContents)
import Development.Shake.FilePath
import Development.Shake.Classes
import Control.DeepSeq

---------------------------------

newtype FindBibTeX = FindBibTeX String deriving (Show,Typeable,Eq,Hashable,Binary,NFData)
type instance RuleResult FindBibTeX = BibTeXCitation

addBibTeXOracle :: String -> [(String,BibTeXCitation)] -> Rules (FindBibTeX -> Action BibTeXCitation)
addBibTeXOracle loc db = addOracle $ \ (FindBibTeX htmlFile) -> do
        need [ loc ]
        case lookup htmlFile db of
          Just target -> return target
          Nothing     -> error $ "unknown bibtex page " ++ show (htmlFile,db)

getBibTeXCitation :: String -> Action BibTeXCitation
getBibTeXCitation = askOracle . FindBibTeX

-----------------------------------

data BibTeXCitation = BibTeXCitation String String [(String,String)] deriving (Show,Read,Typeable,Eq,Ord)

instance Hashable BibTeXCitation where
        hashWithSalt s (BibTeXCitation a b cs) = hashWithSalt s (a,b,cs)

instance Binary BibTeXCitation where
  put (BibTeXCitation a b cs) = put a >> put b >> put cs
  get = do a <- get
           b <- get
           cs <- get
           return $ BibTeXCitation a b cs

instance NFData BibTeXCitation where
  rnf (BibTeXCitation a b cs) = rnf (a,b,cs)

readBibTeX :: String -> IO [(BibTeXCitation)]
readBibTeX fileName = do
        txt <- readFile fileName
        let bib = Parsec.runP P.file () fileName txt
        case bib of
          Right bibs -> return [ (BibTeXCitation (B.entryType bib)
                                                 (B.identifier bib)
                                                 (B.fields bib))
                               | bib <- bibs
                               ]
          Left msg -> fail $ show msg

asciiBibText :: BibTeXCitation -> String
asciiBibText (BibTeXCitation a b cs) = F.entry (B.Cons a b cs)


lookupBibTexCitation :: String -> BibTeXCitation -> Maybe String
lookupBibTexCitation nm (BibTeXCitation a b cs) = lookup nm cs

filterBibTexCitation :: (String -> Bool) -> BibTeXCitation -> BibTeXCitation
filterBibTexCitation fn  (BibTeXCitation a b cs) =  BibTeXCitation a b (filter (fn . fst) cs)

getBibTexCitationTag :: BibTeXCitation -> String
getBibTexCitationTag (BibTeXCitation _ b _) = b


-- Try and normalize the name to something reasonable.
tagToFileName :: String -> String
tagToFileName nm = concatMap fn nm -- ++ ".html"
  where
          fn ':' = "-"
          fn o   = [o]

