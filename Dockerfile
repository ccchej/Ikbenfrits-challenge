FROM ruby:2.7.1

ENV APP_HOME /Ikbenfrits-challenge

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs libsqlite3-dev && apt-get install -y yarn

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME

CMD yarn install --check-files && bundle exec rails db:migrate db:seed && bundle exec rails s -p 3000 -b '0.0.0.0'
