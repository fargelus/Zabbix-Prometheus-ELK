FROM ruby:2.7.2-alpine3.11

WORKDIR /metric
COPY ruby_gc_collector.rb /metric
COPY Gemfile /metric
RUN bundle

EXPOSE 9999

CMD ["ruby", "ruby_gc_collector.rb"]
