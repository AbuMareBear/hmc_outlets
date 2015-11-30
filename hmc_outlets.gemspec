# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hmc_outlets/version'

Gem::Specification.new do |spec|
  spec.name          = "hmc_outlets"
  spec.version       = HmcOutlets::VERSION
  spec.authors       = ["Abdullah Hashim"]
  spec.email         = ["aprenticebutchr@gmail.com"]
  spec.summary       = "Gives some basic information on certified outlets"
  spec.description   = "Checks against HMC's outlet page and collects data about outlets registered with HMC, including if they are certified or revoked."
  spec.homepage      = "https://github.com/AprenticeButchr/hmc_outlets"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "guard", '~> 2.13'
  spec.add_development_dependency "guard-rspec", "~> 4.6"
  spec.add_development_dependency "webmock", "~> 1.22"
  spec.add_development_dependency "coveralls", "~> 0.8"
  spec.add_runtime_dependency "nokogiri", "~> 1.6"
end
