#!/bin/bash

target_file="Tagesspiegel-${1:-`date -d "today" +"%d.%m.%Y"`}.mobi"
send_to="###@###.###, ###@###.###" #insert your kindle e-mail address(es) here
send_from="###@###.###" #insert mail-from address here

perl tagesspiegel.pl

echo "Mailtext" | mailx -s "Heutiger Tagesspiegel" -a $target_file -r $send_from $send_to

rm "$target_file"

exit 0
