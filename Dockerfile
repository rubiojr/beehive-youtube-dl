FROM golang:1.13
WORKDIR /go/src/github.com/rubiojr
RUN git clone https://github.com/muesli/beehive
RUN cd beehive && git checkout rubiojr-experimental && make

FROM debian:latest  
RUN apt update && apt install -y redis-tools curl ffmpeg python
RUN apt clean
RUN curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
RUN chmod a+rx /usr/local/bin/youtube-dl
WORKDIR /root/
COPY beehive.conf /root/
COPY beehive-wrapper /root/
COPY beeydl /usr/local/bin
COPY --from=0 /go/src/github.com/rubiojr/beehive/beehive .
CMD ["./beehive-wrapper"]
