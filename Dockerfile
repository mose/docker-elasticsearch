FROM mose/faria-basedock
MAINTAINER mose <mose@mose.com>

RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get -y -qq update > /dev/null
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get install -y oracle-java7-installer

ENV ELASTICSEARCH_VERSION 0.90.5
RUN mkdir /elasticsearch
ADD https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz \
    /elasticsearch/src
ADD files/elasticsearch.yml /elasticsearch/etc/elasticsearch.yml

WORKDIR /elasticsearch/src/bin
RUN ./plugin --install royrusso/elasticsearch-HQ

EXPOSE 9200
EXPOSE 9300

