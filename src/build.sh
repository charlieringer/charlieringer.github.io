#!/bin/bash

# Build all of the plain static html pages (everything except the blog)
cat header.html index.html footer.html > ../index.html
cat header.html publications.html footer.html > ../publications.html
cat header.html cv.html footer.html > ../cv.html

# # Process blog posts.
# shopt -s nullglob
# suffix=".md"
# prefix="blogs/"

# # Start buiilding the landing page
# cat header.html blog_landing.html > ../blog.html

# #Go through each blog (backwards)
# for f in $(ls -1 blogs/*.md | sort -r) 
# do
# 	#Get the file name
# 	filename=${f#"$prefix"}
# 	filename=${filename%"$suffix"}
# 	#Get the data substring
# 	date=${filename:4:10}

# 	blog_url=${filename%"$suffix"}
# 	finaldest=blogs/${filename:15}.html
# 	#Get the title (for index building purposes)
# 	title=`grep -m 1 "^# .*" $f | sed s/"# "//g`

# 	audience=`grep -m 1 "^###### .*" $f | sed s/"###### "//g`
	

# 	#Turn the markdown into html
# 	pandoc $f > tmp.html

# 	#And save it to as the finished file
# 	cat post_header.html tmp.html footer.html > ../$finaldest

# 	#Get some sample content (400 chars)
# 	sample=`grep -o '<p>.*</p>' tmp.html` 
# 	sample=${sample:0:600}

# 	#Remove temp file
# 	rm tmp.html

# 	#And add a short linked version to the blog landing page
# 	cat blog_short.html | sed "s#{{FILE}}#$finaldest#g" | sed "s#{{TITLE}}#$title#g" | sed "s#{{DATE}}#$date#g" | sed "s#{{AUDIENCE}}#$audience#g" |  sed "s#{{SAMPLE_BODY}}#$sample#g" >> ../blog.html

# done

# # Finish buiilding the landing page
# cat footer.html >> ../blog.html