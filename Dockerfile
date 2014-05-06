FROM mose/faria-basedock
MAINTAINER mose <mose@mose.com>

RUN apt-get -y -qq update > /dev/null
RUN apt-get install -y python-software-properties > /dev/null
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get -y -qq update > /dev/null
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get install -y oracle-java7-installer > /dev/null

ENV ELASTICSEARCH_VERSION 0.90.5
RUN mkdir /elasticsearch
ADD https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz \
    /tmp/
RUN tar xzf /tmp/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz
RUN mv elasticsearch-$ELASTICSEARCH_VERSION elasticsearch/src
ADD files/elasticsearch.yml /elasticsearch/etc/elasticsearch.yml

WORKDIR /elasticsearch/src/bin
RUN ./plugin --install royrusso/elasticsearch-HQ

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9200
EXPOSE 9300

