FROM ruby:2.6.6-slim

LABEL maintainer Travis CI GmbH <support+travis-live-docker-images@travis-ci.com>

# packages required for bundle install
RUN ( \
   apt-get update ; \
   # update to deb 10.8
   apt-get upgrade -y ; \
   apt-get install -y git make gcc g++ \
   && rm -rf /var/lib/apt/lists/*; \
   bundle config --global frozen 1;\
   mkdir -p /app;\
)

# throw errors if Gemfile has been modified since Gemfile.lock
WORKDIR /app

# Copy app files into app folder
COPY . /app

RUN (\
   gem install bundler -v '2.0.1'; \
   bundle install --deployment --without development test --clean; \
   apt-get remove -y git make gcc g++; \
   bundle clean && rm -rf /app/vendor/bundle/ruby/2.6.0/cache/*; \
   for i in `find /app/vendor/ -name \*.o -o -name \*.c -o -name \*.h`; do rm -f $i; done; \
   )

CMD ["bundle", "exec", "puma", "-C", "lib/travis/yml/web/puma.rb"]
