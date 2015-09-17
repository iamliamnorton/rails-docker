FROM alpine:dev
MAINTAINER Liam Norton

ENV RUBY_VER 2.2.3
RUN apk add --update make nodejs gcc libc-dev git ruby libxml2-dev libxslt-dev libffi-dev yaml-dev openssl-dev zlib-dev readline-dev postgresql-dev \
  && mkdir -p /usr/src/app \
  && git clone https://github.com/postmodern/ruby-install /usr/src/ruby-install \
  && cd /usr/src/ruby-install \
  && make install \
  && ruby-install --system ruby $RUBY_VER -- --disable-install-rdoc \
  && gem install bundler --no-ri --no-rdoc \
  && bundle config --global build.nokogiri --use-system-libraries \
  && apk del ruby \
  && rm -rf /usr/src/* /var/cache/apk/*

ENV APP_HOME /usr/src/app/
WORKDIR $APP_HOME

ONBUILD COPY Gemfile $APP_HOME
ONBUILD COPY Gemfile.lock $APP_HOME

# ONBUILD RUN bundle update --system
ONBUILD RUN bundle install --system

ONBUILD COPY . $APP_HOME

CMD [ "irb" ]
