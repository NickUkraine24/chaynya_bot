# frozen_string_literal: true

require 'httparty'

module Lib
  class Items
    class << self
      def process
        response = HTTParty.get(ENV['URL_FOR_GETTING_ITEMS'])

        response.parsed_response
      end
    end
  end
end
