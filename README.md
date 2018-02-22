A breakable toy for testing out docker and tools/applications with docker.

Currently used to test a stats setup:

```
ruby app generating "stats"
-> veneur
  split
  -> datadog (via veneur's datadog "sink")
  -> brubeck (via veneur's "forward_address")
    -> (graphite)
      carbon
       -> whisper
       -> graphite-web
```

with graphite-web served on nginx+gunicorn.

docker containers:

  harbor                veneur
+---------+           +---------+
| ruby app|   ---->   | veneur  |
| brubeck |   <----   |         |
| carbon  |           +---------+
| whisper |
+---------+


## Run it

* clone brubeck, carbon, graphite-web, and whisper into this directory
   * `git clone git@github.com:github/brubeck.git`
   * `git clone git@github.com:graphite-project/carbon.git`
   * `git clone git@github.com:graphite-project/graphite-web.git`
   * `git clone git@github.com:graphite-project/whisper.git`
* run `./start_with_network.sh`
  * this will create a docker network bridge, build the harbor and veneur images, and run the two containers, linking them to the network
* access the web interface for metrics with `http://localhost:8080/render?target=ship`
