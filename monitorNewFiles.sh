inotifywait -m /tmp/lyricRecorderResources/audioInput -e create -e moved_to |
    while read path action file; do
                    echo "The file '$file' appeared in directory '$path' via '$action'"
                    # do something with the file
                  /tmp/lyricRecorderResources/scripts/audioConvert.sh "/tmp/lyricRecorderResources/ffmpeg/ffmpeg" "/tmp/lyricRecorderResources/audioInput/sample.mp3" "/tmp/lyricRecorderResources/audioOutput/sample.wav" > /dev/null 2>&1
    done