# Dockerfile for Rails API-only Backend
# Multi-stage build to reduce final image size

# Build stage
FROM ruby:3.2.2-slim as builder

# Install essential build dependencies
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Set up work directory
WORKDIR /rails

# Install gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 2.6.8 && \
    bundle config set --local retry '5' && \
    bundle config set --local jobs "$(nproc)" && \
    bundle install --jobs "$(nproc)" --retry 5

# Runtime stage
FROM ruby:3.2.2-slim

# Install runtime dependencies only
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    postgresql-client \
    libpq5 \
    && rm -rf /var/lib/apt/lists/*

# Set up work directory
WORKDIR /rails

# Copy installed gems from the builder stage
COPY --from=builder /usr/local/bundle /usr/local/bundle

# Copy application code
COPY . .

# Expose Port
EXPOSE 3000

# Start Server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
