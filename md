<html>
<head>
<title>
EECS 448: Lab 3
</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--favicon-->
<p><link href="images/favicon.ico" rel="icon" type="image/x-icon" /></p>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
<pre><code>    &lt;div class=&quot;jumbotron&quot;&gt;
        &lt;h1&gt;Lab 3: Web Languages&lt;/h1&gt;
        &lt;h2&gt;EECS 448, Spring 2018&lt;/h2&gt;
&lt;/div&gt;

        &lt;h3&gt;Due Time&lt;/h3&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            This lab is due one week from the start of your lab session.
        &lt;/p&gt;&lt;hr&gt;

        &lt;h3&gt;Lab Type&lt;/h3&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            This lab is an individual lab.
            &lt;strong&gt;NOTE&lt;/strong&gt;: Attendance is required for a grade.
        &lt;/p&gt;

        &lt;h3&gt;Additional Resources&lt;/h3&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            &lt;ul&gt;
                &lt;li&gt;&lt;a href=&quot;https://www.w3schools.com/&quot;&gt;W3Schools&lt;/a&gt;&lt;/li&gt;
                &lt;li&gt;&lt;a href=&quot;https://getbootstrap.com/&quot;&gt;Bootstrap&lt;/a&gt;&lt;/li&gt;
                &lt;li&gt;&lt;a href=&quot;Lab3Slides.pdf&quot;&gt;Lab3 slides&lt;/a&gt;&lt;/li&gt;
            &lt;/ul&gt;
        &lt;/p&gt;

        &lt;h3&gt;Topics&lt;/h3&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            &lt;ul&gt;
                &lt;li&gt;HTML&lt;/li&gt;
                &lt;li&gt;CSS&lt;/li&gt;
                &lt;li&gt;JavaScript&lt;/li&gt;
                &lt;li&gt;Bootstrap&lt;/li&gt;
            &lt;/ul&gt;
        &lt;/p&gt;

        &lt;h3&gt;HTML: html, body, and head&lt;/h3&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            All HTML documents are surrounded by the &amp;lt;html&amp;gt; tag.
            It is an open and close tag that then contains the &amp;lt;head&amp;gt;
            and &amp;lt;body&amp;gt; tags. The head contains some of the behind the scenes
            mechanics. One tag you can put in the head right away is the &amp;lt;title&amp;gt;
            tag. The title tag controls what a browser tab or window title bar’s text is.
            &lt;br&gt;
            The body contains all the content that the is contained with the web page.
            Every, image, link, paragraph, or table resides here.
            &lt;pre&gt;&amp;lt;html&amp;gt;
&amp;lt;head&amp;gt;
    &amp;lt;title&amp;gt; My first web page &amp;lt;/title&amp;gt;
&amp;lt;/head&amp;gt;

&amp;lt;body&amp;gt;
           In this sentence I have
           &amp;lt;br&amp;gt;
           &amp;lt;u&amp;gt;underlined words&amp;lt;/u&amp;gt;, &amp;lt;i&amp;gt;italicized words&amp;lt;/i&amp;gt;,
           &amp;lt;br&amp;gt;
           and &amp;lt;b&amp;gt;bold words&amp;lt;/b&amp;gt;.
&amp;lt;/body&amp;gt;</code></pre>
&lt;/html&gt;
</pre>
<pre><code>        &lt;/p&gt;

        &lt;h4&gt;HTML: Images&lt;/h4&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
        You can put images in your web page, but first you need to pick an image
        to embed. There are two ways to refer to an image:
        &lt;ul&gt;
            &lt;li&gt;Download and use a local image&lt;/li&gt;
            &lt;li&gt;
                Refer to the address of an existing image
                &lt;pre&gt;&amp;lt;img src=&quot;theFileNameHere.jpg&quot;&amp;gt;&lt;/pre&gt;
            &lt;/li&gt;
        &lt;/ul&gt;
        &lt;/p&gt;

        &lt;p class=&quot;text-justify&quot;&gt;
            The img tag is a stand alone tag like the break tag. It doesn’t surround
            anything. Notice how we added the src=&quot;theFileNameHere.jpg&quot; portion?
            That’s because the tag alone isn’t enough information.
            We can’t just tell the browser we need an image, we need to tell the
            browser which image we want. If we just list the file name, the
            browser will assume it’s in a local folder.
            What you added was an HTML attribute. All attributes have a similar format:
            &amp;lt;tag attribute = &quot;value&quot;&amp;gt;
            &lt;br&gt;&lt;br&gt;
            You pick some attribute then set it equal to a value in quotation.
            There are many attributes and values for various tasks.
            For example, depending on your image, it may be very large.
            You can control that. You just need to add a height and a width attribute.
            &lt;pre&gt;&amp;lt;img src=&quot;theFileNameHere.jpg&quot; height=&quot;300&quot; width=&quot;500&quot;&amp;gt;&lt;/pre&gt;

            You can control the pixel heights and widths of the image.
            You can also do percentages if you like:
            &lt;pre&gt;&amp;lt;img src=&quot;theFileNameHere.jpg&quot; height=&quot;20%&quot; width=&quot;50%&quot;&amp;gt;&lt;/pre&gt;
            &lt;/p&gt;

        &lt;p class=&quot;text-justify&quot;&gt;
            The other way we can display an image in our page is link to an existing one
            instead of downloading a copy. To do this, you can go back to that image
            you found and instead of saving a copy, choose &quot;copy image location&quot;
            (or the wording that matches your browser). You would then replace the
            file name with this URL. Sometimes these URLs get very long,
            so you don’t have to do this right now, but it’s good to be aware of.&lt;br&gt;
            Reference: &lt;a href=&quot;https://www.w3schools.com/tags/tag_img.asp&quot;&gt;W3Schools HTML &amp;lt;img&amp;gt; Tag&lt;/a&gt;
        &lt;/p&gt;

        &lt;h4&gt;HTML: Anchor tags&lt;/h4&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            To create clickable links, you will use the anchor tag, or &amp;lt;a&amp;gt;
            for short. Here’s the template:
            &lt;pre&gt;&amp;lt;a href=&quot;http://completeURLhere.com&quot;&amp;gt; The words you want to be clickable &amp;lt;/a&amp;gt;&lt;/pre&gt;
        &lt;/p&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            For example if I wanted to make a link that took people to google when
            they clicked on the words &quot;Go to google&quot; I would do the following:
            &lt;pre&gt;&amp;lt;a href=&quot;http://google.com&quot;&amp;gt; Go to google &amp;lt;/a&amp;gt;&lt;/pre&gt;

            Remember to include the &quot;http://&quot; part. Even though you don’t type that
            in browsers anymore, you’ll need it in your code. It acts as a flag that
            tells the browser it need to use the Hyper Text Transfer Protocol, or
            in other words, it needs to grab something from the internet instead
            of something local. &lt;br&gt;Reference: &lt;a href=&quot;https://www.w3schools.com/html/html_links.asp&quot;&gt;HTML Links&lt;/a&gt;
        &lt;/p&gt;

        &lt;h4&gt;HTML paragraphs&lt;/h4&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            Paragraphs are used to create, well, paragraphs. The text get some
            automatic formatting, like ensuring its not a the same line as some
            other piece of content. The template is:
            &lt;br&gt;&lt;i&gt;Your paragraph here&lt;/i&gt;
            &lt;br&gt;
            Reference: &lt;a href=&quot;https://www.w3schools.com/html/html_paragraphs.asp&quot;&gt;HTML Paragraphs&lt;/a&gt;
        &lt;/p&gt;

        &lt;h3&gt;Javascript&lt;/h3&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            JavaScript is language that runs client-side and is used to make your
            HTML pages interactive and responsive. (It is not a scripted version of
            Java, it&#39;s a whole other language.)
            &lt;br&gt;
            A lot of syntax is the same or similar to C++/Java:
            &lt;ul&gt;
                &lt;li&gt;if statement (boolean operators)&lt;/li&gt;
                &lt;li&gt;loops&lt;/li&gt;
                &lt;li&gt;functions (mostly)&lt;/li&gt;
            &lt;/ul&gt;

            Important changes:
            &lt;ul&gt;
                &lt;li&gt;All variables are declared with the key words &lt;code&gt;var&lt;/code&gt;&lt;/li&gt;
                &lt;li&gt;There is no explicit class key word (see reference below)&lt;/li&gt;
                &lt;li&gt;JS files don&#39;t include each other, instead they are all included in your HTML document&lt;/li&gt;
            &lt;/ul&gt;
            Useful reference and tutorials: &lt;a href=&quot;https://www.w3schools.com/js/default.asp&quot;&gt;W3schools JavaScript Tutorial&lt;/a&gt;
        &lt;/p&gt;

        &lt;h4&gt;Connecting JavaScript to an HTML file&lt;/h4&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            In the head tag of your HTML file, include the script tag:
            &lt;pre&gt;&amp;lt;html&amp;gt;
&amp;lt;head&amp;gt;
     &amp;lt;script type=&quot;text/javascript&quot;
             src=&quot;fileName.js&quot;&amp;gt;
     &amp;lt;/script&amp;gt;
&amp;lt;/head&amp;gt;&lt;/pre&gt;
            The script tag is an open-close tag that we can put our JS code in
            (and it helps modularity to simply link to another file).
        &lt;/p&gt;

        &lt;h4&gt;Events&lt;/h4&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            JavaScript functions can be called in reaction to an event occurring.
            For example, we can define a button in HTML to call a JavaScript method.
            &lt;pre&gt;&amp;lt;!-- In html --&amp;gt;</code></pre>
&lt;button onclick=“myFunc()”&gt;
</pre>
<pre><code>            &lt;pre&gt;//In JS file</code></pre>
function myFunc() { alert(“You called my function!”); }
</pre>
<pre><code>            Other useful events:
            &lt;ul&gt;
                &lt;li&gt;&lt;code&gt;onclick&lt;/code&gt; (when a tag is clicked)&lt;/li&gt;
                &lt;li&gt;&lt;code&gt;onmouseover&lt;/code&gt; (when the mouse browses over a tag)&lt;/li&gt;
                &lt;li&gt;&lt;code&gt;onmouseout&lt;/code&gt; (when the mouse leaves the area of a tag)&lt;/li&gt;
                &lt;li&gt;&lt;code&gt;onload&lt;/code&gt; (when a tag is loaded; setting this event in the
                    body tag will call a JavaScript function when the page loads)&lt;/li&gt;
            &lt;/ul&gt;
        &lt;/p&gt;


        &lt;h4&gt;Manipulating HTML&lt;/h4&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            JavaScript can manipulate nearly every aspect of an HTML dynamically.
            To give JavaScript control over an HTML element you must do two steps:
            &lt;ul&gt;
                &lt;li&gt;In the HTML file: Give a tag you want JavaScript to be able to affect an id attribute&lt;li&gt;
                &lt;li&gt;In the JavaScript file: Find the element by it&#39;s id and manipulate the attribute in question&lt;/li&gt;
            &lt;/ul&gt;

            &lt;pre&gt;&amp;lt;!-- In HTML --&amp;gt;</code></pre>
&lt;img src=“file.jpg” id=“myImgId” width=“100” height=“200”&gt; &lt;br&gt; &lt;button value=“ZOOM!” onclick=“zoomIn()”&gt;
</pre>
<pre><code>            &lt;pre&gt;//In JS</code></pre>
function zoomIn() { var theImgTag = document.getElementById(“myImgId”); theImgTag.width = 1000; theImgTag.height = 2000; }
</pre>
<pre><code>        &lt;/p&gt;

        &lt;h3&gt;Exercise 1: Password validator&lt;/h3&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            Create a webpage that allows the user to enter a password two times in
            order to validate it.
            &lt;br&gt;
            Web page content:
            &lt;ul&gt;
                &lt;li&gt;Two password fields: first to enter the password and a second one to verify it&lt;/li&gt;
                &lt;li&gt;A button labelled &quot;Validate&quot; that alerts one of the following messages -
                Display informative error message if any of the following occur:
                    &lt;ul&gt;
                        &lt;li&gt;The passwords entered don&#39;t match&lt;/li&gt;
                        &lt;li&gt;the passwords are not at least 8 characters long&lt;/li&gt;
                    &lt;/ul&gt;
                &lt;/li&gt;
            &lt;/ul&gt;
        &lt;/p&gt;

        &lt;h3&gt;Exercise 2: Slide show!&lt;/h3&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            Create a new webpage that has a single &lt;code&gt;img&lt;/code&gt; tag and
            two buttons labeled previous and next. Your slideshow should:
            &lt;ul&gt;
                &lt;li&gt;Contain at least five pictures of your choice (appropriate for class)&lt;/li&gt;
                &lt;li&gt;Cycle through all the pictures&lt;/li&gt;
                &lt;li&gt;Wrap around to the beginning if I keep pushing next&lt;/li&gt;
                &lt;li&gt;Wrap around to the end if I keep pushing previous&lt;/li&gt;
                &lt;li&gt;Force the images to be all the same size regardless of the
                    original image files&#39; dimensions&lt;/li&gt;
            &lt;/ul&gt;
        &lt;/p&gt;

        &lt;h3&gt;Cascading Style Sheets (CSS)&lt;/h3&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            CSS, or Cascading Style Sheet, is a whole other language from HTML
            (that&#39;s right, you’re learning two languages in one day). It&#39;s entirely
            a helper language used to define how HTML should appear. It includes
            styling details such as, colors, sizes, font families, and background image.
        &lt;/p&gt;

        &lt;h4&gt;CSS: Setup&lt;/h4&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            In the same folder your webpage is in, create file called &lt;code&gt;myStyle.css&lt;/code&gt;.
            Note the different extension? That&#39;s because this file will only contain CSS code.
            Now add the following code to your CSS file:
            &lt;pre&gt;p</code></pre>
{ background-color: blue; }
</pre>
<pre><code>            Now, go back to your HTML sheet. Inside the head tag, put the following:
            &lt;pre&gt;&amp;lt;html&amp;gt;
&amp;lt;head&amp;gt;
    &amp;lt;link href=”myStyle.css”
        rel=”stylesheet”
        type=”text/css”/&amp;gt;
&amp;lt;/head&amp;gt;&lt;/pre&gt;

    Now make sure all the files are saved and refresh your browser.
    You should see your paragraph now has a blue background.
        &lt;/p&gt;


        &lt;h4&gt;CSS: Basic&lt;/h4&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            All styling code follows this template:
            &lt;pre&gt;tagName</code></pre>
<p>{ style-attribute1: someValue; style-attribute2: someValue; }</p>
someOtherTag { style-attribute1: someValue; style-attribute2: someValue; }
</pre>
You can style almost any HTML tag. There are many attributes, such as background-color, and values, such as, blue. We’ll discuss a few here.
</p>
<pre><code>        &lt;h4&gt;CSS: Background colors&lt;/h4&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            You already have a background color for your paragraph.
            Now let’s give one to the whole page!
            To do so, we&#39;ll style the tag that surrounds everything, the body.
            &lt;pre&gt;body</code></pre>
{ background-color: red; }
</pre>
There are lots of color keywords, such as red and blue. There are many others, but if you need a very specific color, you can use W3Schools’ color picker. <br>Reference: <a href="https://www.w3schools.com/colors/colors_picker.asp">HTML Color Picker</a>
</p>
<pre><code>        &lt;h4&gt;CSS: text color&lt;/h4&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            You can give the text in your web page it&#39;s own color. The &quot;color&quot; attribute
            colors the color the text inside of a given tag. Example:
            &lt;pre&gt;p</code></pre>
{ background-color: red; color: white; }
</pre>
Now all paragraphs will have a red background and white text.
</p>
<pre><code>        &lt;h4&gt;CSS: Font&lt;/h4&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            There are many things we can change about font. The color attribute controls
            the color of text, but there are several attributes that apart of the font
            attribute collection. Here’s an example:
            &lt;pre&gt;p</code></pre>
{ background-color: red; color: white; font-family: arial font-size: 22pt; }
</pre>
<pre><code>            Now all paragraphs will have 22pt (the size), white arial font on a
            red background.
            &lt;br&gt;
            Reference: &lt;a href=&quot;https://www.w3schools.com/css/css_font.asp&quot;&gt;CSS Fonts&lt;/a&gt; and
            &lt;a href=&quot;https://www.w3schools.com/cssref/default.asp#font&quot;&gt;CSS Reference&lt;/a&gt;
        &lt;/p&gt;

        &lt;h4&gt;CSS: Background images&lt;/h4&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            Lots of tags can have a background image. We&#39;ll give our web page a
            particular background image. You could give your lists or paragraphs
            background images too, but they probably aren&#39;t large enough to utilize
            them well.
            &lt;br&gt;
            The following code gives the body a background image of a gif (assuming
            it is in the same folder) that will stretch to cover 100% of the screen
            (the size) and not repeat.
            &lt;pre&gt;body</code></pre>
{ background-image: url(img_flwr.gif); background-size: 100%; background-repeat: no-repeat; }
</pre>
<pre><code>    You can also play with how the background image behaves when scrolling by
    tinkering with the position. For example if you don’t want is to move when
    the user scrolls do the following:
    &lt;pre&gt;body</code></pre>
{ background-image: url(img_flwr.gif); background-size: 100%; background-repeat: no-repeat; background-attachment: fixed; }
</pre>
References: <br> Basic: <a href="http://www.w3schools.com/cssref/pr_background-image.asp">http://www.w3schools.com/cssref/pr_background-image.asp</a> <br> Position: <a href="http://www.w3schools.com/cssref/pr_background-position.asp">http://www.w3schools.com/cssref/pr_background-position.asp</a> <br> Size: <a href="http://www.w3schools.com/cssref/css3_pr_background-size.asp">http://www.w3schools.com/cssref/css3_pr_background-size.asp</a> <br> Repeat: <a href="http://www.w3schools.com/cssref/pr_background-repeat.asp">http://www.w3schools.com/cssref/pr_background-repeat.asp</a>
</p>
<pre><code>        &lt;h4&gt;CSS: hover&lt;/h4&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            CSS can also detect some simple events that occur on your page and adjust
            the styling accordingly. For example, you can change the styling of a tag
            to respond when a user has their mouse over it.
            Let&#39;s look at two blocks of styling for the anchor tag (our clickable links):
            &lt;pre&gt;a</code></pre>
<p>{ background-color: blue; color: red; }</p>
a:hover { background-color: red; color: blue }
</pre>
<pre><code>            With these two blocks, the user will see red text with a blue background
            for all links normally, but when they hover over the link, the styling
            will invert. Now, you can adjust any styling you want. You could make a
            paragraph that increases its font size when hovered over or a list that
            changes from arial to courier font when hovered over.
            &lt;br&gt;
            Reference: &lt;a href=&quot;https://www.w3schools.com/cssref/sel_hover.asp&quot;&gt;CSS :hover Selector&lt;/a&gt;
        &lt;/p&gt;

        &lt;h4&gt;CSS: classes&lt;/h4&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            Sometimes you don’t want all tags to receive the same styling.
            One option is to create classes. It’s a two part process.
            On the CSS side you need to create a styling block that will contain
            the information for your special tags.
            &lt;pre&gt;p</code></pre>
<p>{ color: blue; background-color: yellow; }</p>
p.halloween { color: orange; background-color: black; }
</pre>
<pre><code>            Default paragraphs will have the top block of styling, but any paragraph
            that I choose to can have the halloween themed styling. I just have to
            tell HTML which ones I want to be special.
            To do so, I include the class attribute on the HTML side:
            &lt;pre&gt;&amp;lt;p&gt; Normal paragraph &amp;lt;/p&amp;gt;</code></pre>
&lt;p class=”halloween”&gt; Booo! &lt;/p&gt;
</pre>
<pre><code>        &lt;/p&gt;

        &lt;h3&gt;Exercise 3: Personal Profile&lt;/h3&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            Make a profile page that is styled with CSS. Have fun with this.
            You can make a profile about anybody or anything. You are not required
            to make this about yourself or post any personal information online.
            This profile can be entirely fictional.
            &lt;br&gt;
            HTML Requirements:
            &lt;ul&gt;
                &lt;li&gt;Profile picture&lt;/li&gt;
                &lt;li&gt;Biographical paragraph&lt;/li&gt;
                &lt;li&gt;Hyperlinks to favorite web sites&lt;/li&gt;
                &lt;li&gt;Embedded youtube video&lt;/li&gt;
            &lt;/ul&gt;

            CSS Requirements:
            &lt;ul&gt;
                &lt;li&gt;Use all the attributes listed in the CSS section at least once&lt;/li&gt;
                &lt;li&gt;The page should not induce seizures or headaches - in other words,
                    mind the color pallet you choose&lt;/li&gt;
                &lt;li&gt;All text should be easy to read&lt;/li&gt;
            &lt;/ul&gt;

        &lt;/p&gt;

        &lt;h3&gt;CSS manipulation through JavaScript&lt;/h3&gt;
        &lt;h4&gt;The Style Attribute&lt;/h4&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            JavaScript, in addition to accessing and manipulating HTML, can change
            the styling of any tag you give it access to. The reality is that there
            is a style attribute that nearly every tag has. For example, one could
            style a paragraph tag using the style attribute:
            &lt;pre&gt;&amp;lt;p style=&quot;background-color:red&quot;&amp;gt; This text will have a red background &amp;lt;/p&amp;gt;&lt;/pre&gt;
        &lt;/p&gt;

        &lt;h4&gt;Levels of Styling&lt;/h4&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            The previous example was an inline level styling.
            The other levels of styling, in order of precedence, are:
            &lt;ul&gt;
                &lt;li&gt;&lt;i&gt;inline&lt;/i&gt;: the style code is given in the tag
                    (highest precedence, but only applies styling to that one tag)&lt;/li&gt;
                &lt;li&gt;&lt;i&gt;document level&lt;/i&gt;: the style code is written inside a style
                    tag in the head of the HTML document
                    (second precedence, but only applies to the document it&#39;s written in)&lt;/li&gt;
                &lt;li&gt;external: what we do in this lab, writing the code in an external CSS sheet
                    (lowest precedence, but the most modular)&lt;/li&gt;
            &lt;/ul&gt;
        &lt;/p&gt;

        &lt;h4&gt;The JavaScript style Object&lt;/h4&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            The Document Object Model (DOM) that defines the structure of an HTML
            document has inside of it a style object. To access the style object,
            you simply need to access the tag, via its id, like in previous exercises.
            You can then access the style object of that tag.
        &lt;/p&gt;

        &lt;h3&gt;Exercise 4: CSS Manipulation&lt;/h3&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            Create a web page that has a paragraph with some dummy text.
            Near the paragraph have text fields to accept the following values:
            &lt;br&gt;
            Border:
            &lt;ul&gt;
                &lt;li&gt;red value&lt;/li&gt;
                &lt;li&gt;green value&lt;/li&gt;
                &lt;li&gt;blue value&lt;/li&gt;
                &lt;li&gt;width&lt;/li&gt;
            &lt;/ul&gt;

            Background color:
            &lt;ul&gt;
                &lt;li&gt;red value&lt;/li&gt;
                &lt;li&gt;green value&lt;/li&gt;
                &lt;li&gt;blue value&lt;/li&gt;
            &lt;/ul&gt;

            Finally, have a button that, when clicked, changes the border and
            background color to be as specified. You can use either the rgb() method
            or a color code, but you should tell the user what units they are in
            (00-FF or 0-255).
            &lt;pre&gt;//in JavaScript</code></pre>
<p>//Access the tag: var someTag = docuement.getElementById(“theTagsId”);</p>
//Change the style attribute someTag.style.backgroundColor = “red”;
</pre>
<pre><code>            &lt;b&gt;NOTE&lt;/b&gt;: the names of the style attributes in CSS are all hyphenated
            (e.g., background-color) but in JavaScript they are nearly all converted to camel-case.
            &lt;br&gt;
            Here is a &lt;a href=&quot;https://www.w3schools.com/jsref/dom_obj_style.asp&quot;&gt;reference&lt;/a&gt;
            of the style properties that JavaScript can access and change.
        &lt;/p&gt;

        &lt;h3&gt;Bootstrap&lt;/h3&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            Writing your own HTML, CSS, and JS code from scratch may be fun ... but you may never get
            them to look as good webpages you see online ... and there is also this compatibility issue
            e.g., some webpages look very ugly on mobile devices
            &lt;br&gt;
            Here comes Bootstrap ... an open source toolkit for developing with HTML, CSS, and JS
            (&lt;a href=&quot;https://getbootstrap.com/&quot;&gt;https://getbootstrap.com/&lt;/a&gt;)
            &lt;br&gt;
            Let&#39;s get started. Write the following code into a file called &lt;code&gt;test.html&lt;/code&gt; and open this
            file in a browser:
            &lt;pre&gt;&amp;lt;html&amp;gt;
&amp;lt;head&amp;gt;
  &amp;lt;title&amp;gt;EECS 448: Accessing the EECS Databases&amp;lt;/title&amp;gt;
  &amp;lt;meta charset=&quot;utf-8&quot;&amp;gt;
  &amp;lt;meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1&quot;&amp;gt;
  &amp;lt;!--favicon--&amp;gt;&amp;lt;link href=&quot;images/favicon.ico&quot; rel=&quot;icon&quot; type=&quot;image/x-icon&quot; /&amp;gt;

  &amp;lt;link rel=&quot;stylesheet&quot; href=&quot;https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css&quot;&amp;gt;
  &amp;lt;script src=&quot;https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js&quot;&amp;gt;&amp;lt;/script&amp;gt;
  &amp;lt;script src=&quot;https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js&quot;&amp;gt;&amp;lt;/script&amp;gt;
&amp;lt;/head&amp;gt;

&amp;lt;body&amp;gt;&amp;lt;div class=&quot;container&quot;&amp;gt;
    &amp;lt;div class=&quot;jumbotron&quot;&amp;gt;
        &amp;lt;h1&amp;gt;hello Bootstrap world!&amp;lt;/h1&amp;gt;
        &amp;lt;h2&amp;gt;EECS 448, Spring 2018&amp;lt;/h2&amp;gt;
    &amp;lt;/div&amp;gt;

    &amp;lt;h3&amp;gt;What is going on?&amp;lt;/h3&amp;gt;
    &amp;lt;p class=&quot;text-justify&quot;&amp;gt;
        Bootstrap is a &quot;built-in responsive, mobile-first projects on the web with
        the world&#39;s most popular front-end component library.
        Bootstrap is an open source toolkit for developing with HTML, CSS, and JS.
        Quickly prototype your ideas or build your entire app with our Sass variables
        and mixins, responsive grid system, extensive prebuilt components,
        and powerful plugins built on jQuery.&quot; (Source: &amp;lt;a href=&quot;https://getbootstrap.com/&quot;&amp;gt;https://getbootstrap.com/&amp;lt;/a&amp;gt;)
        &amp;lt;br&amp;gt;
        In other words, you have a whole universe of CSS and JS to take advantage of
        without having to write the actual CSS and JS code.
    &amp;lt;/p&amp;gt;

&amp;lt;/div&amp;gt;&amp;lt;/body&amp;gt;</code></pre>
&lt;/html&gt;
</pre>
<pre><code>        &lt;/p&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            What just happened? We leveraged Bootstrap&#39;s content delivery network
            (BootstrapCDN) to  load CSS, JavaScript and images remotely, from its servers.
            In other words, with a few lines of code in the &lt;code&gt;head&lt;/code&gt; section, we have access
            to the whole Bootstrap universe (sure, we need to have an internet connection for the CDN to work).
            For other options to install Bootstrap see:
            &lt;a href=&quot;https://getbootstrap.com/docs/4.0/getting-started/download/&quot;&gt;https://getbootstrap.com/docs/4.0/getting-started/download/&lt;/a&gt;
            &lt;br&gt;&lt;br&gt;
            Why did I use Bootstrap 3 instead on the latest version 4?
            Personal preference, I like the colors and styles in version 3.
            You can go with version 4; use:
            &lt;pre&gt;</code></pre>
&lt;link rel=“stylesheet” href=“https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css”&gt; &lt;script src=“https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js”&gt;&lt;/script&gt; &lt;script src=“https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js”&gt;&lt;/script&gt;
</pre>
<pre><code>            instead of:

            &lt;pre&gt;</code></pre>
&lt;link rel=“stylesheet” href=“https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css”&gt; &lt;script src=“https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js”&gt;&lt;/script&gt; &lt;script src=“https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js”&gt;&lt;/script&gt;
</pre>
<pre><code>        &lt;h3&gt;Excercise 5: Personal Profile with Bootstrap&lt;/h3&gt;
        &lt;p class=&quot;text-justify&quot;&gt;Change the profile page from Exercise 3 to use Bootstrap
            (keep the old Exercise 3 profile page in a separate file for submission purposes).
            You may start from and customize &lt;code&gt;test.html&lt;/code&gt; for your new profile page or
            you can leverage one of &lt;a href=&quot;https://getbootstrap.com/docs/4.0/examples/&quot;&gt;Bootstrap&#39;s example pages&lt;/a&gt;.

        &lt;h3&gt;Excercise 6: Publication&lt;/h3&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            In addition to uploading your code to GitHub, place your files in the
            &lt;code&gt;public_html&lt;/code&gt; folder on your EECS account.
            You can then access them through the URL:
            &lt;pre&gt;http://people.eecs.ku.edu/~yourKUuserNameHere</code></pre>
Example: http://people.eecs.ku.edu/~jrmiller //Display Dr. Miller’s EECS homepage //Why not mine? Mine is just redirecting you to my webpage hosted on the ITTC infrastructure.
</pre>
<pre><code>        &lt;/p&gt;

        &lt;p class=&quot;text-justify&quot;&gt;
            &lt;b&gt;Note&lt;/b&gt;: If you experience any problems with lab equipment or your EECS account,
            contact the Engineering Technical Support Center immediately.
            Please be polite and as detailed as possible: &lt;a href=&quot;https://tsc.ku.edu/request-support-engineering-tsc&quot;&gt;Ticket Form&lt;/a&gt;
        &lt;/p&gt;

        &lt;h4&gt;Making an index.html&lt;/h4&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            When you go to your people.eecs page, you&#39;ll most likely see a simple file listing.
            This is the default behavior of apache. To make a landing page, you can write an
            &lt;code&gt;index.html&lt;/code&gt; file.
            &lt;br&gt;
            In your index.html
            &lt;ul&gt;
                &lt;li&gt;Use links, JS, or whatever means you like to create a menu to all your other exercises&lt;/li&gt;
                &lt;li&gt;Spruce it up with styling so it&#39;s more than just four hyper links - apache could have given us that without any effort&lt;/li&gt;
            &lt;/ul&gt;

            If you already are using your default homepage just provide us with a sub-folder URL.
            &lt;br&gt;Example:
            &lt;pre&gt;http://people.eecs.ku.edu/~KuUserName/subdir/eecs448/lab03&lt;/pre&gt;
        &lt;/p&gt;

        &lt;h3&gt;Web Language Summary&lt;/h3&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            &quot;Are all these webpages I look at everyday just text files in directories with code written in them?&quot;
            &lt;br&gt;Yes, they are. &lt;br&gt;
            Sorry young padawan, the world wide web isn&#39;t magic. It&#39;s science. Computer science to be exact.
        &lt;/p&gt;

        &lt;h3&gt;Rubric&lt;/h3&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            &lt;ul&gt;
                &lt;li&gt;[20pts] Exercise 1: Password validator&lt;/li&gt;
                &lt;li&gt;[25pts] Exercise 2: Slide show&lt;/li&gt;
                &lt;li&gt;[15pts] Exercise 3: Profile&lt;/li&gt;
                &lt;li&gt;[20pts] Exercise 4: CSS Manipulation&lt;/li&gt;
                &lt;li&gt;[10pts] Exercise 5: Profile with Bootstrap&lt;/li&gt;
                &lt;li&gt;[10pts] Exercise 6: Publication&lt;/li&gt;
            &lt;/ul&gt;
        &lt;/p&gt;

        &lt;h3&gt;Submission&lt;/h3&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            Before the deadline, send an email to your TA with the following information:
            &lt;ul&gt;
                &lt;li&gt;Email Subject line: &lt;code&gt;EECS448 LastName FirstName StudentID Lab03&lt;/code&gt;&lt;/li&gt;
                &lt;li&gt;The body of the email should contain:&lt;/li&gt;
            &lt;ul&gt;
                &lt;li&gt;The Github URL to your lab03 code&lt;/li&gt;
                &lt;li&gt;Your publication URL e.g., &lt;code&gt;people.eecs.ku.edu/~YourOnlineID&lt;/code&gt;&lt;/li&gt;
            &lt;/ul&gt;
        &lt;/ul&gt;
        &lt;/p&gt;

        &lt;h3&gt;Additional Reading&lt;/h3&gt;
        &lt;h4&gt;Classes in Javascript&lt;/h4&gt;
        &lt;p class=&quot;text-justify&quot;&gt;
            You can make classes in Javascript in a variety, although confusing, ways.
            One way is with functions, but coming from C++/Java would probably feel very odd.
            The good news is that Javascript is adding the keywords and semantics a C++/Java person would be used to.
            &lt;a href=&quot;https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes&quot;&gt;Source&lt;/a&gt;
            &lt;br&gt;&lt;b&gt;NOTE&lt;/b&gt;: This is a fairly new standard and not guaranteed to work in all browsers.
        &lt;/p&gt;
    &lt;/td&gt;&lt;/tr&gt;&lt;/table&gt;
    This initial version of this lab was designed by &lt;a href=&quot;http://www.eecs.ku.edu/people/faculty/jwgibbo&quot;&gt;Dr. John Gibbons&lt;/a&gt;
&lt;/div&gt;&lt;/body&gt;</code></pre>
</html>
