# Start with a base image containing Ruby runtime
FROM ruby:3.1.3

# Set the work directory in the image to /productito
WORKDIR /productito

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the main application.
COPY . ./

# Expose port 9292 to the Docker host, so we can access our API from outside
EXPOSE 9292

# The command that starts our app
CMD ["bundle", "exec", "rackup", "-p", "9292", "-o", "0.0.0.0"]
