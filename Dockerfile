FROM rails:4.2.5

WORKDIR /src/docker-rails-test-app

COPY Gemfile /src/docker-rails-test-app/
COPY Gemfile.lock /src/docker-rails-test-app/
RUN bundle install

VOLUME /src/docker-rails-test-app

# Default command is to run a rails server on port 3000
CMD ["rails", "server", "--binding", "0.0.0.0", "--port", "3000"]
EXPOSE 3000