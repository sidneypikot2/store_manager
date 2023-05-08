# syntax=docker/dockerfile:1
FROM ruby:3.2.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client libvips42 libvips-dev
WORKDIR /store_manager
COPY Gemfile /store_manager/Gemfile
COPY Gemfile.lock /store_manager/Gemfile.lock
RUN bundle install
RUN bundle exec rails assets:precompile
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "3000", "0.0.0.0"]