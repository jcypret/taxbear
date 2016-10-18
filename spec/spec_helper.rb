$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'taxbear'
require 'webmock/rspec'
require 'aruba/rspec'

def register_api_token(token)
  ENV["HOME"] = File.expand_path("../../tmp/home", __FILE__)
  Taxbear::Config.save_token(token)
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
