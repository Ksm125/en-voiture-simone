FROM ruby:3.2.2-alpine3.18 AS base

ENV BUNDLER_VERSION 2.4.19

RUN apk upgrade && apk add --no-cache --update build-base \
    curl \
    linux-headers \
    git \
    postgresql-dev \
    postgresql-client \
    vips \
    python3 \
    gcompat

RUN gem install bundler --default -v ${BUNDLER_VERSION}

FROM base

ENV USERNAME voiture

RUN addgroup ${USERNAME}
RUN adduser --disabled-password --ingroup ${USERNAME} ${USERNAME}

WORKDIR /voiture-app

COPY Gemfile /voiture-app/Gemfile
COPY Gemfile.lock /voiture-app/Gemfile.lock

RUN bundle install && bundle clean --force && rm -r /voiture-app/Gemfile*

RUN chown -R ${USERNAME}:${USERNAME} /usr/local/bundle/
COPY --chown=$USERNAME:$USERNAME . /voiture-app
RUN mkdir -p /voiture-app/tmp /voiture-app/log && chmod -R 765 /voiture-app/tmp /voiture-app/log

EXPOSE 3000

USER $USERNAME:$USERNAME
# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
