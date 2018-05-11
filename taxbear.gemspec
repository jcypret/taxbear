# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "taxbear/version"

Gem::Specification.new do |spec|
  spec.name          = "taxbear"
  spec.version       = Taxbear::VERSION
  spec.authors       = ["Justin Cypret"]
  spec.email         = ["jcypret@gmail.com"]

  spec.summary       = "A CLI for interacting with the TaxJar API."
  spec.homepage      = "https://github.com/jcypret/taxbear"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 2.1.0"
  spec.add_development_dependency "simplecov"

  spec.add_dependency "thor", "~> 0.19"
  spec.add_dependency "httparty", "~> 0.14"
  spec.add_dependency "terminal-table"
end
