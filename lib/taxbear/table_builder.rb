require "terminal-table"

module Taxbear
  class TableBuilder
    # A class to build tables for outputing to STDOUT.

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
          headings: align_each_cell_center(get_header_rows(rates)),
          rows: [align_each_cell_center(format_rates(rates))]
        ).to_s
        output << "\n\n"

        puts output
      end

      private

      def align_each_cell_center(row)
        row.map {|c| align_center(c)}
      end

      def align_center(value)
        {value: value, alignment: :center}
      end

      def get_header_rows(rates)
        [*rates.fetch_values("state", "county", "city"), "DISTRICT(S)", "TOTAL"]
      end

      def format_rates(rates)
        rates
          .fetch_values("state_rate", "county_rate", "city_rate", "combined_district_rate", "combined_rate")
          .map {|r| format_rate(r)}
      end

      def format_rate(rate)
        sprintf('%.3f', rate.to_f * 100) + "%"
      end
    end
  end
end
