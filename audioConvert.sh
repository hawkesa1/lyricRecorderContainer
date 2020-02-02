echo Started Audio Convert Script
echo about to call ffmpeg
echo ffmpeg -y -i $2 $3
ffmpeg -y -i $2 $3 > /tmp/out.txt 2>&1
echo called ffmpeg
echo Finished Audio Convert Script
exit;