require 'spec_helper'

describe Taxbear::Taxjar do
  describe "#get_rates_by_zipcode", type: :aruba do
    it "calls TaxJar API with zipcode and auth token" do
      register_api_token("definitelynotafaketoken")

      stub = stub_request(:get, "https://api.taxjar.com/v2/rates/72034")
        .with(headers: {"Authorization" => "Token token=definitelynotafaketoken"})
        .to_return(
          status: 200,
          body: fixture('taxjar_zipcode.json'),
          headers: {content_type: "application/json"})

      Taxbear::Taxjar.get_rates_by_zipcode(72034)

      expect(stub).to have_been_requested
    end

    it "raises an exception when request is unsuccessful" do
      stub_request(:get, "https://api.taxjar.com/v2/rates/72034").to_return(status: 401)

      expect {
        Taxbear::Taxjar.get_rates_by_zipcode(72034)
      }.to raise_error(Taxbear::TaxjarError)
    end
  end
end
