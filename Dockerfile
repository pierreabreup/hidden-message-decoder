FROM ruby:2.5-alpine

RUN apk add --no-cache bash
RUN apk add --update \
  build-base \
  && rm -rf /var/cache/apk/*

WORKDIR /usr/src/app

RUN gem install bundler

COPY ./entrypoint.sh /etc/entrypoint.sh
RUN chmod +x /etc/entrypoint.sh
CMD ["/bin/sh"]
ENTRYPOINT ["/etc/entrypoint.sh"]
