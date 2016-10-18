require "thor"
require "httparty"

module Taxbear
  class Taxjar
    # A class to interect with the TaxJar API.
    include HTTParty

    base_uri "https://api.taxjar.com/v2"

    class << self
      # Gets tax rates from TaxJar API based on zipcode.
      #
      # @param zipcode [Integer] the zip code
      # @return [Hash] the rates returned by API
      def get_rates_by_zipcode(zipcode)
        response = get("/rates/#{zipcode}", {headers: headers})

        if response.success?
          response.fetch("rate")
        else
          raise TaxjarError, "Unable to get tax rates from TaxJar API."
        end
      end

      private

      def headers
        {"Authorization" => "Token token=#{Config.get_token}"}
      end
    end
  end
end
