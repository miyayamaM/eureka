FROM ruby:2.5.1

RUN apt-get update -qq && \
  apt-get install -y apt-utils \
  build-essential \
  libpq-dev \
  vim \
  default-mysql-client

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs

ENV LANG C.UTF-8

RUN gem install bundler:1.17.3

WORKDIR /app

ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install -j4

COPY package.json yarn.lock ./
RUN yarn install --check-files

ADD . /app

RUN bundle exec rake action_text:install
RUN bundle exec rails assets:precompile

EXPOSE 3000

