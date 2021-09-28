#!/usr/bin/env bash

# Not very automated, but w/e. There's probably a good way of automating downloading files and "dragging them to the Applications folder"

open https://www.sublimetext.com/download
open https://www.sublimemerge.com/download

echo "Press enter after you've installed Sublime Text and sublime merge"
read

ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
ln -s "/Applications/Sublime Merge.app/Contents/SharedSupport/bin/smerge" /usr/local/bin/smerge
