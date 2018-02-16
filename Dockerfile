# Parent image
FROM ruby:2.4-jessie

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# just for my convenience
RUN apt-get update && apt-get install -y net-tools netcat
# brubeck
RUN apt-get update && apt-get install -y libjansson-dev libmicrohttpd-dev
RUN ./brubeck/script/bootstrap
# graphite
RUN apt-get update && apt-get install -y python-pip python-dev libcairo2-dev libffi-dev build-essential nginx
## webapp
RUN cd graphite-web && pip install --upgrade cffi && pip install -r requirements.txt && python setup.py install
RUN touch /var/log/nginx/graphite.access.log && touch /var/log/nginx/graphite.error.log
RUN chmod 640 /var/log/nginx/graphite.* && chown www-data:www-data /var/log/nginx/graphite.*
RUN cp ./graphite.conf /etc/nginx/sites-available/graphite
RUN ln -s /etc/nginx/sites-available/graphite /etc/nginx/sites-enabled && rm -f /etc/nginx/sites-enabled/default
RUN cp ./graphite-web-local_settings.py /opt/graphite/webapp/graphite/local_settings.py
# carbon and whisper
RUN cd carbon && pip install -r requirements.txt && python setup.py install
RUN cd whisper && pip install -r requirements.txt && python setup.py install
RUN cp ./carbon.conf /opt/graphite/conf/carbon.conf && cp /opt/graphite/conf/storage-schemas.conf.example /opt/graphite/conf/storage-schemas.conf
# all
RUN bundle install

# Make port 80 available to the world outside this container
EXPOSE 80
EXPOSE 8080
EXPOSE 8088

# Define environment variable
ENV NAME harbor

# start carbon-cache, brubeck, the "app"
CMD ./harbor_runner.sh
