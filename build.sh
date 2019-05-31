#!/bin/bash

# Build all of the plain static html pages (everything except the blog)
cat src/header.html src/index.html src/footer.html > index.html
cat src/header.html src/publications.html src/footer.html > publications.html
cat src/header.html src/cv.html src/footer.html > cv.html

# Process blog posts.
shopt -s nullglob
suffix=".md"
prefix="src/blogs/"
for f in src/blogs/*.md
do
	#Get the file name (question: Do I need this?)
	filename=${f#"$prefix"}
	filename=${filename%"$suffix"}

	#Get the title (for index building purposes)
	title=`grep -m 1 "^# .*" $f | sed s/"# "//g`
	echo "Processing $filename"
	echo $title

	pandoc $f > src/blog_html/$filename.html
done

cat src/header.html src/blog.html src/footer.html > blog.html