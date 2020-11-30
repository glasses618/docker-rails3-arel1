FROM ubuntu:12.04
MAINTAINER glasses618
ENV LANG=C.UTF-8

RUN apt-get update && apt-get -y install vim git-core build-essential zlib1g-dev libssl-dev libreadline-gplv2-dev tklib libyaml-dev wget sqlite3 libsqlite3-dev

WORKDIR $HOME
RUN mkdir workspace
WORKDIR $HOME/workspace

RUN wget https://cache.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p551.tar.gz
RUN tar xvfz ruby-1.9.3-p551.tar.gz
WORKDIR $HOME/workspace/ruby-1.9.3-p551
RUN ./configure && make && make install

WORKDIR $HOME/workspace
RUN wget https://ftp.tw.freebsd.org/distfiles/ruby/rubygems-1.8.30.tgz
RUN tar xvfz rubygems-1.8.30.tgz
WORKDIR $HOME/workspace/rubygems-1.8.30
RUN ruby setup.rb
RUN gem install rails -v 3.0.0

WORKDIR $HOME/workspace/arel
ADD Gemfile $HOME/workspace/arel
ADD Gemfile.lock $HOME/workspace/arel
RUN bundle

ADD . $HOME/workspace/arel
