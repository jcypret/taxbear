require "spec_helper"

describe "Taxbear::CLI" do
  describe "#zip" do
    it "prints table of rates based on entered zip code" do
      allow(Taxbear::Config).to receive(:exists?) { true }
      allow(Taxbear::Config).to receive(:get_token) { "definitelynotafaketoken" }
      stub_request(:get, "https://api.taxjar.com/v2/rates/72034")
        .with(headers: {"Authorization" => "Token token=definitelynotafaketoken"})
        .to_return(
          status: 200,
          body: fixture('taxjar_zipcode.json'),
          headers: {content_type: "application/json"})

      expect(STDOUT).to receive(:puts).with(/Sales Tax Rates for 72034/)

      Taxbear::CLI.new.zip(72034)
    end

    it "it displays error message when unable to connect to TaxJar" do
      allow(Taxbear::Config).to receive(:exists?) { true }
      allow(Taxbear::Config).to receive(:get_token) { "definitelynotafaketoken" }
      stub_request(:get, "https://api.taxjar.com/v2/rates/72034").to_return(status: 401)

      expect(STDOUT).to receive(:puts).with(/✘ Unable to get tax rates from TaxJar API./)

      Taxbear::CLI.new.zip(72034)
    end
  end
end