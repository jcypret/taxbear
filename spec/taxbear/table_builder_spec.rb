require "spec_helper"

describe Taxbear::TableBuilder do
  describe "#print_rates_for_zipcode" do
    it "properly formats table" do
      expected_table = <<-TABLE.strip_heredoc

      +--------+----------+--------+-------------+--------+
      |             Sales Tax Rates for 72034             |
      +--------+----------+--------+-------------+--------+
      |   AR   | FAULKNER | CONWAY | DISTRICT(S) | TOTAL  |
      +--------+----------+--------+-------------+--------+
      | 6.500% |  0.500%  | 1.750% |   0.000%    | 8.750% |
      +--------+----------+--------+-------------+--------+

      TABLE

      expect(STDOUT).to receive(:puts).with(expected_table)

      rates = JSON.parse(File.read(fixture('taxjar_zipcode.json'))).fetch("rate")
      Taxbear::TableBuilder.print_rates_for_zipcode(rates, "72034")
    end
  end
end
