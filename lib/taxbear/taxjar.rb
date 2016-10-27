require "thor"
require "httparty"

module Taxbear
  # Interacts with the TaxJar API.
  class Taxjar
    include HTTParty

    base_uri "https://api.taxjar.com/v2"

    class << self
      # Gets tax rates from TaxJar API based on zipcode.
      #
      # @param zipcode [Integer] the zip code
      # @return [Hash] the rates returned by API
      def get_rates_by_zipcode(zipcode)
        require_api_key
        response = get("/rates/#{zipcode}", headers: auth_header)

        if response.success?
          response.fetch("rate")
        else
          fail TaxjarError, "Unable to get tax rates from TaxJar API."
        end
      end

      # Takes a tokens and returns whether the token is valid.
      #
      # @param token [String] the token
      # @return [Boolean] whether token is valid
      def validate_token(token)
        get("/categories", headers: auth_header(token)).success?
      end

      private

      def require_api_key
        raise_unauthorized unless Config.exists?
      end

      def raise_unauthorized
        fail TaxjarUnauthorized, "You must have a TaxJar API key set to access rates. Use `taxbear login`."
      end

      def auth_header(token = Config.token)
        { "Authorization" => "Token token=#{token}" }
      end
    end
  end
end
