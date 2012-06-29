# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "json_schema_builder/version"

Gem::Specification.new do |s|
  s.name        = "json_schema_builder"
  s.version     = JsonSchemaBuilder::VERSION
  s.authors     = ["Georg Leciejewski"]
  s.email       = ["gl@salesking.eu"]
  s.homepage    = "http://www.salesking.eu"
  s.summary     = %q{Build JSON Schema fields for ActiveRecord models}
  s.description = %q{Build JSON Schema fields for ActiveRecord models}

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
