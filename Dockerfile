FROM ruby:2.6.3

ENV APP_HOME /EternalAlchemy
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN apt-get update && apt-get install -y build-essential libpq-dev

RUN gem install bundler
ADD Gemfile Gemfile.lock $APP_HOME/
RUN bundle check || bundle install --jobs $(nproc)

ADD . $APP_HOME

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
