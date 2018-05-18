require "gparser/version"
require "gparser/airbnb"
require "gmail"

module Gparser
  class Feed
    SOURCES = [Gparser::Airbnb]

    attr_reader :key, :email

    def initialize(email, key)
      @email = email
      @key = key
    end

    def connection
      @connection ||= ::Gmail.connect(:xoauth2, email, key)
    end

    def parse
      SOURCES.map do |source|
        { source.to_s.downcase => source.new(connection).parse }
      end
    end
  end
end
