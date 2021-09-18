FROM ruby:2.6.7-buster

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update

# Install python
RUN apt-get install -y python3 python3-pip

# Install python/pip
RUN pip3 install --no-cache --upgrade pip setuptools

# Get speaker-verification repo
RUN git clone -b fix/logger-issues https://github.com/OnTrack-UG-Squad/speaker-verification.git

RUN export PYTHONPATH=${PYTHONPATH}:/speaker-verification

RUN pip3 install -r ./speaker-verification/requirements.txt

# Install bundler
RUN gem install bundler

# Setup working dir and copy in doubtfire speaker verification code
WORKDIR /app
COPY . /app/

# Install gems
RUN bundle install

CMD ruby app.rb
