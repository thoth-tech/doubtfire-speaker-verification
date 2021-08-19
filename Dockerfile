FROM ruby:2.6.7-buster

# docker-ce-cli apt dependencies
ENV DEBIAN_FRONTEND noninteractive

# What about python?

# I was under the impression the python stuff was for another repo

# you build it in the other repo - then copy the final into here as part of this build script (i.e. into this container)
# then you can access it from the integration you are writing
# but you can get that working once "hello world" works :)

# is this in the doubtfire-deploy project folder? -- Not yet
# you need it to be - then you can: edit the doubtfire-api compose file to include it, and send it messages from the api etc
# though for now I guess you can test it by injecting messages from the rabbitmq management interface (??)

# I can push this code now and then add the submodule in doubtfire-api, would that be an easier way to continue?

# The working location in the container is:
WORKDIR /app

# We need bundler to get our gems...
RUN gem install bundler

# Now get the Gemfile and its lock... then install these gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Is not needed as long as the equivalent HOST DIR
# has been initiated with the correct FACLs.
# RUN mkdir /home/overseer/work-dir
    # && chown -R 1001:999 /home/overseer/work-dir \
    # && chmod -R 777 /home/overseer/work-dir