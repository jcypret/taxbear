require "thor"

module Taxbear
  class CLI < Thor
    desc "zip ZIPCODE", "displays sales tax rates for supplied zip code"
    def zip(zipcode)
      ensure_api_key_is_available

      rates = Taxjar.get_rates_by_zipcode(zipcode)
      TableBuilder.print_rates_for_zipcode(rates, zipcode)
    rescue TaxjarError => e
      print_error(e.message)
    end

    private

    def ensure_api_key_is_available
      unless File.exists?(CONFIG_FILE)
        token = ask("What is your TaxJar API token?")
        File.write(CONFIG_FILE, token)
      end
    end

    def print_error(error)
      error_message = "✘ #{error}"
      puts set_color(error_message, :red)
    end
  end
end
