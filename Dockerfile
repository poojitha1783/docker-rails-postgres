# Dockerfile for Rails application

# Use the official Ruby image with the matching version specified in the Gemfile
FROM ruby:3.3.1

# Update and install dependencies
RUN apt-get update -qq && \
    apt-get install -y nodejs postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV RAILS_ENV=production \
    RAILS_ROOT=/app \
    APP_HOME=/app/web

# Set working directory
WORKDIR $RAILS_ROOT

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock $RAILS_ROOT/

# Install the specific version of Bundler
RUN gem install bundler:2.5.10

# Install gems
RUN bundle install

# Copy the Rails application
COPY . $RAILS_ROOT/

# Expose port 3000 to the Docker host, so we can access the Rails app
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
