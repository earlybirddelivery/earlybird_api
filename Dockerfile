FROM ruby:3.3.1


RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libssl-dev \
  zlib1g-dev \
  libreadline-dev \
  libyaml-dev \
  libncurses5-dev \
  libgdbm-dev \
  libffi-dev \
  libpq-dev \
  git

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install --verbose

COPY . .

RUN bundle exec rake assets:precompile

EXPOSE 3000

ENTRYPOINT ["./entrypoint.sh"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
