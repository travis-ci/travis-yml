FROM ruby:2.6.6-slim

LABEL maintainer Travis CI GmbH <support+travis-live-docker-images@travis-ci.com>

# packages required for bundle install
RUN ( \
   apt-get update ; \
   apt-get install -y --no-install-recommends git make gcc g++ \
   && rm -rf /var/lib/apt/lists/* \
)

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1;
RUN mkdir -p /app
WORKDIR /app

# Copy app files into app folder
COPY . /app

RUN gem install bundler -v '2.0.1'
RUN bundle install --deployment --without development test --clean

CMD bundle exec puma -C lib/travis/yml/web/puma.rb