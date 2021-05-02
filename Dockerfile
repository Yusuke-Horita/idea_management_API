FROM ruby:2.5.7

RUN apt-get update -qq && \
apt-get install -y build-essential \
									 libpq-dev \
									 nodejs \
									 default-mysql-client \
									 vim

RUN mkdir /idea_management_API

WORKDIR /idea_management_API

COPY Gemfile /idea_management_API/Gemfile
COPY Gemfile.lock /idea_management_API/Gemfile.lock

RUN bundle install

COPY . /idea_management_API