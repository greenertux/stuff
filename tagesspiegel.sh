#!/bin/bash

download_path="http://epaper.tagesspiegel.de/epaper/index.php?rel=a4${1:-`date -d "today" +"%d.%m.%Y"`}"

target_file="Tagesspiegel-${1:-`date -d "today" +"%d.%m.%Y"`}.mobi"
send_to="###@###.###, ###@###.###" #insert your kindle e-mail address(es) here

perl tagesspiegel.pl

echo "Mailtext" | mailx -s "Heutiger Tagesspiegel" -a $target_file $send_to

rm "$target_file"

exit 0
