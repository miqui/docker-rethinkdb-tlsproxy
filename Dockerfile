FROM rethinkdb:latest

MAINTAINER Jason Kraus <jkraus@editllc.com>

ENV RETHINKDB_JOIN_ADDR 127.0.0.1:29105

RUN mkdir -p /certs
RUN mkdir -p /conf

RUN apt-get update \
	&& apt-get install -y stunnel4 \
	&& rm -rf /var/lib/apt/lists/*

#TLS certs go here
VOLUME ["/certs"]

ADD ./run.sh /bin
ADD ./stunnel.conf /conf/stunnel.conf
RUN chmod +x /bin/run.sh

EXPOSE 28443

CMD ["/bin/run.sh"]