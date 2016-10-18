require "thor"

module Taxbear
  class CLI < Thor
    desc "zip [ZIPCODE]", "Display sales tax rates for specified zip code"
    def zip(zipcode)
      ensure_api_key_is_available
      rates = Taxjar.get_rates_by_zipcode(zipcode)
      TableBuilder.print_rates_for_zipcode(rates, zipcode)
    rescue TaxjarError => e
      print_error(e.message)
    end

    private

    def ensure_api_key_is_available
      unless Config.exists?
        token = ask("What is your TaxJar API token?")
        Config.save_token(token)
      end
    end

    def print_error(error)
      error_message = "✘ #{error}"
      puts set_color(error_message, :red)
    end
  end
end
