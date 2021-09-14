# FROM ruby:2.6.7-buster

# # docker-ce-cli apt dependencies
# ENV DEBIAN_FRONTEND noninteractive

# # TODO: Add python stuff

# # The working location in the container is:
# WORKDIR /app

# # We need bundler to get our gems...
# RUN gem install bundler

# # Now get the Gemfile and its lock... then install these gems
# COPY Gemfile Gemfile.lock ./
# RUN bundle install

FROM alpine:3.14

RUN apk update

# Install git
RUN apk add git

# Get speaker-verification repo
RUN git clone https://github.com/OnTrack-UG-Squad/speaker-verification.git

# Install python/pip
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

# Install ruby/rails
RUN apk add ruby~=2.7.4
RUN gem install bundler

WORKDIR /app
ADD . /app/

# Install gems
# Some help from https://bundler.io/v2.0/guides/bundler_docker_guide.html
ENV GEM_HOME="/usr/local/bundle"
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH

RUN unset BUNDLE_PATH
RUN unset BUNDLE_BIN

RUN bundle install