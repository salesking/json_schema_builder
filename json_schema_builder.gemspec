# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'schema_builder/version'

Gem::Specification.new do |s|
  s.name        = 'json_schema_builder'
  s.version     = SchemaBuilder::VERSION
  s.authors     = ['Georg Leciejewski']
  s.email       = ['gl@salesking.eu']
  s.homepage    = 'http://www.salesking.eu/dev'
  s.summary     = %q{A good API needs JSON Schema description! Get it right and build JSON Schemata for your ActiveRecord models}
  s.description = %q{The first step to a clean and simple API is a unified API description in form of a shared JSON Schema}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'json'
  s.add_dependency 'gli'
  s.add_dependency 'activesupport'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'activerecord'
  s.add_development_dependency 'sqlite3'
end
