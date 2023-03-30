echo Started Audio Convert Script789
echo about to call ffmpeg
echo ffmpeg -y -i $2 $3

ls -lrt $2

temp=$2
temp="${temp%\"}"
temp="${temp#\"}"
echo alex3 "$temp"

temp1=$3
temp1="${temp1%\"}"
temp1="${temp1#\"}"
echo alex3 "$temp1"

ffmpeg -y -i $temp $temp1
echo called ffmpeg
echo Finished Audio Convert Script
exit;