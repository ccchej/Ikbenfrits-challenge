FROM ruby:2.7.1

ENV APP_HOME /challenge

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs libsqlite3-dev

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME

CMD bundle exec rails db:migrate db:seed && bundle exec rails s -p 3000 -b '0.0.0.0'