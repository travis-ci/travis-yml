FROM ruby:3.2.2-slim as base

# upgrade
RUN apt-get update > /dev/null 2>&1 && \
    apt-get upgrade -y > /dev/null 2>&1 && \
    rm -rf /var/lib/apt/lists/*

# Set app workdir
WORKDIR /app

# Upgrade rubygems
RUN gem update --system 3.4.13 > /dev/null 2>&1

# Gem config
RUN echo "gem: --no-document" >> ~/.gemrc

# Bundle config
RUN bundle config set --global no-cache 'true' && \
    bundle config set --global frozen 'true' && \
    bundle config set --global deployment 'true' && \
    bundle config set --global without 'development test' && \
    bundle config set --global clean 'true' && \
    bundle config set --global jobs `expr $(cat /proc/cpuinfo | grep -c 'cpu cores')` && \
    bundle config set --global retry 3


FROM base as builder

# packages required
RUN apt-get update > /dev/null 2>&1 && \
    apt-get install -y --no-install-recommends git make gcc g++ > /dev/null 2>&1 && \
    rm -rf /var/lib/apt/lists/*

# Copy .ruby-version and .gemspec into container
COPY .ruby-version travis-yml.gemspec ./
COPY ./lib/travis/yml/version.rb ./lib/travis/yml/version.rb

# Copy gemfiles into container
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install


FROM base

LABEL maintainer Travis CI GmbH <support+travis-live-docker-images@travis-ci.com>

# Copy gems from builder
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /app/vendor ./vendor

# Copy app files
COPY . ./

CMD ["bundle", "exec", "puma", "-C", "lib/travis/yml/web/puma.rb"]
