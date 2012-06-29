# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "omniauth-share-one/version"

Gem::Specification.new do |s|
  s.name        = "omniauth-share-one"
  s.version     = OmniAuth::ShareOne::VERSION
  s.authors     = ["Bill Barnett"]
  s.email       = ["bill@gaslightsoftware.com"]
  s.homepage    = "https://github.com/gaslight/omniauth-share-one"
  s.summary     = %q{OmniAuth strategy for ShareOne}
  s.description = %q{OmniAuth strategy for ShareOne}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'omniauth-oauth2', '~> 1.0.0'
  s.add_development_dependency 'rspec', '~> 2.7'
  s.add_development_dependency 'rack-test'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'webmock'  
end
