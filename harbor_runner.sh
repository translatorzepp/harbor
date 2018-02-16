#!/bin/sh

/opt/graphite/bin/carbon-cache.py start
./brubeck/brubeck --config=brubeck.config.json &
service nginx reload
PYTHONPATH=/opt/graphite/webapp gunicorn wsgi --workers=4 --bind=0.0.0.0:8080 --log-file=/var/log/gunicorn.log --preload --pythonpath=/opt/graphite/webapp/graphite &
ruby app.rb
