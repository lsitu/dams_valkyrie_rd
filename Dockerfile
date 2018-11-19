FROM ruby:2.5.1-alpine

RUN apk update && apk upgrade && \
  apk add --no-cache bash git openssh \
  build-base \
  postgresql \
  postgresql-dev \
  nodejs \
  tzdata


RUN addgroup -g 1000 -S damsvalkyrie && \
    adduser -u 1000 -S damsvalkyrie -G damsvalkyrie
USER damsvalkyrie

RUN mkdir /home/damsvalkyrie/app
WORKDIR /home/damsvalkyrie/app
COPY --chown=damsvalkyrie:damsvalkyrie Gemfile* /home/damsvalkyrie/app/
RUN bundle install --jobs 4 --retry 3
COPY --chown=damsvalkyrie:damsvalkyrie . /home/damsvalkyrie/app/