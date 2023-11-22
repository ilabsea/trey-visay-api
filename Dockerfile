FROM ruby:3.1.2

LABEL maintainer="Sokly Heng <sokly@kawsang.com>"

# Install dependencies
RUN apt-get update && \
    apt-get install -y build-essential default-mysql-client nodejs && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /app
WORKDIR /app

# Install gem bundle
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN gem install bundler:2.3.7 && \
  bundle install --jobs 20 --deployment --without development test

# Install the application
COPY . /app

# Copy fonts for PDF rendering
COPY app/assets/fonts /usr/share/fonts

# Generate version file if available
RUN if [ -d .git ]; then git describe --always > VERSION; fi

# Precompile assets
RUN bundle exec rake assets:precompile RAILS_ENV=production

ENV RAILS_LOG_TO_STDOUT=true
ENV RACK_ENV=production
ENV RAILS_ENV=production
EXPOSE 80

# Add scripts
COPY docker/runit-web-run /etc/service/web/run
COPY docker/migrate /app/migrate
COPY docker/database.yml /app/config/database.yml
