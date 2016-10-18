# Taxbear

[![Gem Version](https://badge.fury.io/rb/taxbear.svg)](https://badge.fury.io/rb/taxbear)
[![Build Status](https://travis-ci.org/jcypret/taxbear.svg?branch=master)](https://travis-ci.org/jcypret/taxbear)
[![Code Climate](https://codeclimate.com/github/jcypret/taxbear/badges/gpa.svg)](https://codeclimate.com/github/jcypret/taxbear)
[![Test Coverage](https://codeclimate.com/github/jcypret/taxbear/badges/coverage.svg)](https://codeclimate.com/github/jcypret/taxbear/coverage)

## Installation

    $ gem install taxbear

## Usage

Lookup sales tax rates for a zip code:

```bash
$ taxbear zip 72034
# +--------+----------+--------+-------------+--------+
# |             Sales Tax Rates for 72034             |
# +--------+----------+--------+-------------+--------+
# |   AR   | FAULKNER | CONWAY | DISTRICT(S) | TOTAL  |
# +--------+----------+--------+-------------+--------+
# | 6.500% |  0.500%  | 1.750% |   0.000%    | 8.750% |
# +--------+----------+--------+-------------+--------+
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/taxbear. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.
