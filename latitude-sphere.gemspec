# -*- encoding: utf-8 -*-
require File.expand_path('../lib/latitude-sphere/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jing Dong"]
  gem.email         = ["me@jing.io"]
  gem.description   = %q{Google Latitude utitlity, data analysis and data migration gem}
  gem.summary       = %q{A tool for migrating Google latitude data from one account to another. }
  gem.homepage      = "https://github.com/activars/latitude-sphere"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "latitude-sphere"
  gem.require_paths = ["lib"]
  gem.version       = LatitudeSphere::VERSION

  gem.add_dependency "multi_json",        "~> 1.5.0" 
  gem.add_dependency "google-api-client", "~> 0.5.0"
  gem.add_dependency "thin",              "~> 1.5.0"
  gem.add_dependency "launchy",           "~> 2.1.2"

  gem.add_development_dependency "rspec", "~> 2.6"
end
