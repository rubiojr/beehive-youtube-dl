# Beehive video downloader

Example [Beehive](https://github.com/muesli/beehive) based video downloader implementation.

Needs https://github.com/muesli/beehive/pull/272 so you'll need to build Beehive from that branch.

Sample `beehive.conf` included. Needs Pushover token `changeme` to be replaced with a real token for the notifications to work. 

## Usage

Needs a local Redis server to be running.

Use the beehive config in this repo that has all the hives and chains pre-configured.

Make sure the Redis server and Beehive are running, then:

**To enqueue a video**

`beeydl queue https://www.youtube.com/watch?v=6W5pq4bIzIw`


**To download videos in the queue**

`beeydl poll`


`beeydl --help` will list all the options available.
