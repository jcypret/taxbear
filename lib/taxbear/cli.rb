require "thor"

module Taxbear
  class CLI < Thor
    desc "login", "Set API key used to authenticate with TaxJar"
    def login
      valid_token = false
      until valid_token
        token = ask("What is your TaxJar API token?")
        valid_token = Taxjar.validate_token(token)
        say_nope unless valid_token
      end
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

    def say_nope
      print_error(random_no)
    end

    def random_no
      [
        "Nope, that's not correct.",
        "Sorry, not quite right.",
        "Maybe you should check the website? https://app.taxjar.com/smartcalcs",
        "A for effort… but no.",
        "I'll give you a hint, it's a bunch of random unguessable letters/numbers.",
        "Good try, but unfortunately wrong.",
        "Hmm… that doesn't seem to be working. Maybe something different?"
      ].sample
    end
  end
end
