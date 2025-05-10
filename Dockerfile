FROM ruby:3.3.1

# Install dependencies
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
  git \
  curl \
  nodejs \
  yarn

# Set working directory
WORKDIR /app

# Copy Gemfiles and install Bundler + Gems
COPY Gemfile Gemfile.lock ./

# Install specific bundler version
RUN gem install bundler -v 2.6.8 && \
    bundle _2.6.8_ install --jobs=4 --retry=5 --verbose

# Copy the rest of the app
COPY . .

# Ensure entrypoint has execute permissions
RUN chmod +x ./entrypoint.sh

# Expose app port
EXPOSE 3000

# Entrypoint and startup command
ENTRYPOINT ["./entrypoint.sh"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
