require 'net/http'

module Serverspec
  module Type
    class Curl < Base
      def initialize(endpt)
        @endpoint = %r{^https?://}.match(endpt) ? endpt : "http://#{endpt}"
      end

      def ok?
        begin
          uri = URI(@endpoint)
          response = Net::HTTP.get_response(uri)
        rescue Exception => e
          puts e.message
          return false
        end
        response.code == '200'
      end

      def to_s
        'Curl'
      end
    end

    def curl(endpoint)
      Curl.new(endpoint)
    end
  end
end

include Serverspec::Type
