FROM golang:1.13
WORKDIR /go/src/github.com/muesli
RUN git clone https://github.com/rubiojr/beehive
RUN cd beehive && make

FROM debian:latest  
RUN apt update && apt install -y redis-tools curl ffmpeg python
RUN apt clean
RUN curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
RUN chmod a+rx /usr/local/bin/youtube-dl
WORKDIR /root/
COPY beehive.conf /root/
COPY beehive-wrapper /root/
COPY beeydl /usr/local/bin
COPY --from=0 /go/src/github.com/muesli/beehive/beehive .
CMD ["./beehive-wrapper"]
