FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
# RUN apk update -q && apk add -q libxml2-dev libxslt-dev

ENV APP_HOME /dietopia

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
RUN gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
RUN bundle config mirror.https://rubygems.org https://gems.ruby-china.com

RUN echo "source 'https://rubygems.org'" > Gemfile &&\
    echo "gem 'rails', '5.2.1'" >> Gemfile &&\
    touch Gemfile.lock
RUN bundle install

COPY . $APP_HOME
