A breakable toy for testing out docker and tools/applications with docker.

Currently used to test a stats setup:

```
ruby app generating "stats"
-> brubeck
-> (graphite)
   carbon
    -> whisper
    -> graphite-web
```

with graphite-web served on nginx+gunicorn.

## Run it

* clone brubeck, carbon, graphite-web, and whisper into this directory
   * `git clone git@github.com:github/brubeck.git`
   * `git clone git@github.com:graphite-project/carbon.git`
   * `git clone git@github.com:graphite-project/graphite-web.git`
   * `git clone git@github.com:graphite-project/whisper.git`
* run `docker build -t harbor . && docker run -it -p 8080:8080 harbor`
* access the web interface for metrics with `http://localhost:8080/render?target=ship`
  * if `docker exec`'d into the container, you can also view stats with `whisper-fetch.py --pretty --from=10 /opt/graphite/storage/whisper/ship.wsp | tail -n 25`
