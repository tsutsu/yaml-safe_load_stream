ARG BASE_IMAGE=ruby:2.7
FROM ${BASE_IMAGE}

WORKDIR /app

COPY gems.rb *.gemspec ./
COPY lib/yaml/safe_load_stream/version.rb ./lib/yaml/safe_load_stream/

RUN gem install bundler:2.3.5
RUN bundle install
RUN bundle update --bundler

COPY . .

ENTRYPOINT ["bundle", "exec"]
