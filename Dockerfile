FROM tomcat:9.0

MAINTAINER Alex Hawkes

ARG LYRIC_RECORDER_RESOURCES_DIR="/tmp/lyricRecorderResources"

COPY ./lyricrecorder.war /usr/local/tomcat/webapps/
COPY ./lyricrecorderws.war /usr/local/tomcat/webapps/

ENV JAVA_OPTS="-DLYRIC_SERVER_URL=http://localhost:8080/lyricrecorderws/services/form/part-file-name -DSERVER_RESOURCES_LOCATION=$LYRIC_RECORDER_RESOURCES_DIR -DOPERATING_SYSTEM=UNIX"

## FFMPEG Stuff:

RUN apt-get update
RUN apt-get install -y ffmpeg
RUN apt-get install -y vim

RUN \
		mkdir $LYRIC_RECORDER_RESOURCES_DIR &&\
		mkdir $LYRIC_RECORDER_RESOURCES_DIR/ffmpeg &&\
		mkdir $LYRIC_RECORDER_RESOURCES_DIR/audioInput &&\
		mkdir $LYRIC_RECORDER_RESOURCES_DIR/audioOutput &&\
		mkdir $LYRIC_RECORDER_RESOURCES_DIR/scripts &&\
		cd $LYRIC_RECORDER_RESOURCES_DIR/ffmpeg && \
		ln -s /usr/bin/ffmpeg ffmpeg 
		
COPY ./audioConvert.sh $LYRIC_RECORDER_RESOURCES_DIR/scripts 

RUN chmod +x $LYRIC_RECORDER_RESOURCES_DIR/scripts/audioConvert.sh 



RUN apt-get install dos2unix
RUN dos2unix $LYRIC_RECORDER_RESOURCES_DIR/scripts/audioConvert.sh
		
RUN apt-get install -y inotify-tools

COPY ./monitorNewFiles.sh $LYRIC_RECORDER_RESOURCES_DIR/scripts
RUN chmod +x $LYRIC_RECORDER_RESOURCES_DIR/scripts/monitorNewFiles.sh 
RUN dos2unix $LYRIC_RECORDER_RESOURCES_DIR/scripts/monitorNewFiles.sh
##CMD ["/tmp/lyricRecorderResources/scripts/monitorNewFiles.sh", ""]
