require "terminal-table"

module Taxbear
  # Builds tables for outputing to STDOUT.
  class TableBuilder
    class << self
      # Takes the rates and prints them as a nice table to STDOUT.
      #
      # @param rates [Hash] the rates
      # @return [nil] returns nothing, prints to STDOUT
      def print_rates_for_zipcode(rates, zipcode)
        output = ""
        output << "\n"
        output << Terminal::Table.new(
          title: "Sales Tax Rates for #{zipcode}",
          headings: align_cells_center(get_rate_headers(rates)),
          rows: [align_cells_center(get_rate_values(rates))]
        ).to_s
        output << "\n\n"

        puts output
      end

      private

      def align_cells_center(row)
        row.map { |c| align_center(c) }
      end

      def align_center(value)
        { value: value, alignment: :center }
      end

      def get_rate_headers(rates)
        [*rates.fetch_values("state", "county", "city"), "DISTRICT(S)", "TOTAL"]
      end

      def get_rate_values(rates)
        rates
          .fetch_values("state_rate", "county_rate", "city_rate", "combined_district_rate", "combined_rate")
          .map { |r| format_rate(r) }
      end

      def format_rate(rate)
        format("%.3f", rate.to_f * 100) + "%"
      end
    end
  end
end
