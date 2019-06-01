#!/bin/bash

# Build all of the plain static html pages (everything except the blog)
cat src/header.html src/index.html src/footer.html > index.html
cat src/header.html src/publications.html src/footer.html > publications.html
cat src/header.html src/cv.html src/footer.html > cv.html

# Process blog posts.
shopt -s nullglob
suffix=".md"
prefix="src/blogs/"

cat src/header.html src/blog.html > blog.html

for f in src/blogs/*.md
do
	#Get the file name
	filename=${f#"$prefix"}
	filename=${filename%"$suffix"}
	finaldest=blogs/$filename.html
	#Get the title (for index building purposes)
	title=`grep -m 1 "^# .*" $f | sed s/"# "//g`
	date=${filename:0:10}
	#Turn the markdown into html
	pandoc $f > src/blog_html/$filename.html
	#And save it to as the finished file
	cat src/header.html src/blog_html/$filename.html src/blog_footer.html > $finaldest

	#And add it to the blog page
	cat src/blog_template.html | sed "s#{{FILE}}#$finaldest#g" | sed "s#{{TITLE}}#$title#g" | sed "s#{{DATE}}#$date#g" |  sed "s#{{SAMPLE_BODY}}#$finaldest#g" >> blog.html

done

cat src/footer.html >> blog.html