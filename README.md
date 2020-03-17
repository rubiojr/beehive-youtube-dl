# Beehive video downloader

Example [Beehive](https://github.com/muesli/beehive) based video downloader implementation.

* Enqueue videos to be downloaded
* Notifies videos have been enqueued via Pushover
* Download enqueued videos using youtube-dl
* Notifies when videos have been downloaded via Pushover

Needs https://github.com/muesli/beehive/pull/272 so you'll need to build Beehive from that branch.

Sample `beehive.conf` included. Needs Pushover token `changeme` to be replaced with a real token for the notifications to work.

## Workflow

Queueing videos:

```



                     POST YouTube URL     +------------------------+   Save URL   +-------------+
                                          |                        |              |             |
   beeydl queue  -----------------------> |  Beehive HTTP server   +--------------> Redis Server
                                          |                        |              |             |
                                          +------------------------+              +-------------+
                                                            |
                                                            |         +------------+
                                                            +-------->+            |
                                                                      |  Pushover  |
                                                Send notification     |            |
                                                                      +------------+

```

Downloading videos:

```

                     +-------------+
                     |             |
   beeydl poll  +---->  Redis Chan |
         +      |    |             |
         v      |    +-------------+
      get key   |
         +      |    +-------------------------+
         v      +----+                         |
    youtube-dl  |    | Download queued Video   |
         +      |    |                         |
         |      |    +-------------------------+
         |      |
         v      |    +-------------+
   publish msg  +--->+             |
                     | Redis Chan  |         +----------+                +------------+
                     |             |         |          |                |            |
                     +-------------+         | Beehive  | +------------->+  Pushover  |
                                 +---------->+          |                |            |
                                             +----------+                +------------+
```

## Usage

The easiest way is to clone this repository and use the `docker-compose.yml` file included.

Replace Pushover token placeholders with your own tokens.

```
git clone https://github.com/rubiojr/beehive-youtube-dl
cd beehive-youtube-dl
docker build -t beeydl .
export PUSHOVER_APP_TOKEN=my-app-token
export PUSHOVER_USER_TOKEN=my-user-token
docker-compose up
```

You can then queue videos locally using:

```
./beeydl queue "https://youtube...."
```

A `ydl-video` directory will be created automatically in the current directory and the videos will be downloaded there.

A `config` directory will also be created to persist Beehive's configuration. 
