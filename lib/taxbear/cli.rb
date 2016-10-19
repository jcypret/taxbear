require "thor"

module Taxbear
  class CLI < Thor
    desc "login", "Set API key used to authenticate with TaxJar"
    def login
      token = ask("What is your TaxJar API token?")
      Config.save_token(token)
      print_success "Success! You are now ready to access the TaxJar API."
    end

    desc "zip [ZIPCODE]", "Display sales tax rates for specified zip code"
    def zip(zipcode)
      rates = Taxjar.get_rates_by_zipcode(zipcode)
      TableBuilder.print_rates_for_zipcode(rates, zipcode)
    rescue => e
      print_error(e.message)
    end

    private

    def print_error(error)
      error_message = "✘ #{error}"
      puts set_color(error_message, :red)
    end

    def print_success(message)
      success_message = "✔︎ #{message}"
      puts set_color(success_message, :green)
    end
  end
end
