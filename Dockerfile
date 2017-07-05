FROM ruby:2.3.4-slim

ENV APP_ROOT /app
ENV RAILS_ENV production

RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main' 9.6 > /etc/apt/sources.list.d/pgdg.list
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

RUN apt-get update && apt-get install -y --no-install-recommends \
  git \
  make \
  g++ \
  tzdata \
  libxml2 \
  postgresql-client-9.6 \
  libpq-dev \
  bzip2 \
  ca-certificates \
  libffi-dev \
  libgdbm3 \
  libssl-dev \
  libyaml-dev \
  procps \
  zlib1g-dev
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test --jobs=4

COPY . $APP_ROOT
RUN bundle exec rake assets:precompile
