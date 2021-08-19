FROM ruby:2.6.7-buster

# docker-ce-cli apt dependencies
ENV DEBIAN_FRONTEND noninteractive

# TODO: Add python stuff

# The working location in the container is:
WORKDIR /app

# We need bundler to get our gems...
RUN gem install bundler

# Now get the Gemfile and its lock... then install these gems
COPY Gemfile Gemfile.lock ./
RUN bundle install
