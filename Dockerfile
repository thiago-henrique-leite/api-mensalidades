FROM ruby:2.7.1

RUN mkdir /billing-api
WORKDIR /billing-api

COPY Gemfile /billing-api/Gemfile
COPY Gemfile.lock /billing-api/Gemfile.lock

RUN bundle install && bundle update --bundler

COPY . /billing-api
