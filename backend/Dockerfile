# Dockerfile for Rails API-only Backend

FROM ruby:3.2.2-slim

# Install essential dependencies
# - build-essential: for compiling gems
# - libpq-dev: for the 'pg' gem (PostgreSQL)
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    postgresql-client

# Clean up apt cache to reduce image size
RUN rm -rf /var/lib/apt/lists/*

# Set up work directory
WORKDIR /rails

# Install Gems
# Gemfile.lock will be updated by bundle install since Gemfile has changed
COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install

# Copy Application Code
COPY . .

# Expose Port
EXPOSE 3000

# Start Server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]