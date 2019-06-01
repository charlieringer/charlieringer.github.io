#!/bin/bash

# Build all of the plain static html pages (everything except the blog)
cat src/header.html src/index.html src/footer.html > index.html
cat src/header.html src/publications.html src/footer.html > publications.html
cat src/header.html src/cv.html src/footer.html > cv.html

# Process blog posts.
shopt -s nullglob
suffix=".md"
prefix="src/blogs/"

# Start buiilding the landing page
cat src/header.html src/blog_landing.html > blog.html

#Go through each blog
for f in $(ls -1 src/blogs/*.md | sort -r) 
do
	#Get the file name
	filename=${f#"$prefix"}
	filename=${filename%"$suffix"}
	finaldest=blogs/$filename.html
	#Get the title (for index building purposes)
	title=`grep -m 1 "^# .*" $f | sed s/"# "//g`
	date=${filename:4:10}

	#Turn the markdown into html
	pandoc $f > src/tmp.html

	#And save it to as the finished file
	cat src/post_header.html src/tmp.html src/post_footer.html > $finaldest

	#Get some sample content (400 chars)
	sample=`grep -o '<p>.*</p>' src/tmp.html` 
	sample=${sample:0:400}

	#Remove temp file
	rm src/tmp.html

	#And add a short linked version to the blog landing page
	cat src/blog_short.html | sed "s#{{FILE}}#$finaldest#g" | sed "s#{{TITLE}}#$title#g" | sed "s#{{DATE}}#$date#g" |  sed "s#{{SAMPLE_BODY}}#$sample#g" >> blog.html

done

# Finish buiilding the landing page
cat src/footer.html >> blog.html