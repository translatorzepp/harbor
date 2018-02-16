A breakable toy for testing out docker and tools/applications with docker.

Currently used to set up brubeck -> graphite (-> carbon -> graphite-web)

To run:

* clone brubeck, carbon, graphite-web, and whisper into this directory
* run `docker build -t harbor . && docker run -it -p 8080:8080 harbor`
* access the web interface for metrics with `http://localhost:8080/render?target=ship`

