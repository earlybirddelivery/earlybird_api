FROM ruby:3.2

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN bundle exec rake assets:precompile

EXPOSE 3000

ENTRYPOINT ["./entrypoint.sh"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
