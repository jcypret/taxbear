require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'taxbear'
require 'webmock/rspec'
require 'aruba/rspec'

WebMock.disable_net_connect!(allow: "codeclimate.com")

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
