# HmcOutlets

[![Coverage Status](https://coveralls.io/repos/AprenticeButchr/hmc_outlets/badge.svg?branch=master&service=github)](https://coveralls.io/github/AprenticeButchr/hmc_outlets?branch=master)

[![Gem Version](https://badge.fury.io/rb/hmc_outlets.svg)](https://badge.fury.io/rb/hmc_outlets)

[![Build Status](https://travis-ci.org/AprenticeButchr/hmc_outlets.svg?branch=v0.1.0)](https://travis-ci.org/AprenticeButchr/hmc_outlets)

This a pretty simple gem that grabs HMC's certified list and gives back some simple information.

It requires `nokogiri` because HMC is still in the darkages of the internet and they still don't have an API to query against. :p

Seriously, who doesn't have an API these days?

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hmc_outlets'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hmc_outlets

## Usage

Need to see if an outlet is certified?

```ruby
HmcOutlets.certified?("Outlet Name")
```

Want to check if an outlet has been removed?

```ruby
HmcOutlets.removed?("Outlet Name")
```

Just a little note: Removed is for once certified outlets that have had their certificate removed for whatever 

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/AprenticeButchr/hmc_outlets/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
