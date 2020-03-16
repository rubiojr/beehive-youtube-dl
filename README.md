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

Needs a local Redis server to be running.

Use the beehive config in this repo that has all the hives and chains pre-configured.

Make sure the Redis server and Beehive are running, then:

**To enqueue a video**

`beeydl queue https://www.youtube.com/watch?v=os8FvDpfKfw`


**To download videos in the queue**

`beeydl poll`


`beeydl --help` will list all the options available.
