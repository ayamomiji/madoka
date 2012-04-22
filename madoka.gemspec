# -*- encoding: utf-8 -*-
require File.expand_path('../lib/madoka/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["ayaya"]
  gem.email         = ["ayaya@ayaya.tw"]
  gem.description   = %q{A model based on ActiveModel that provides mass assignment with role support.}
  gem.summary       = %q{A model based on ActiveModel that provides mass assignment with role support.}
  gem.homepage      = "https://github.com/ayamomiji/madoka"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "madoka"
  gem.require_paths = ["lib"]
  gem.version       = Madoka::VERSION

  gem.add_dependency 'activemodel'
  gem.add_dependency 'activerecord'
  gem.add_dependency 'activesupport'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '~> 2.5'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'shoulda-matchers'
  gem.add_development_dependency 'rr'
end
