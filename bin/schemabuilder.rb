#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib')))

require 'json_schema_builder'

require 'gli'
include GLI

version JsonSchemaBuilder::VERSION

desc "Creates schema file in current directory/json-schema/*.json"
command :build do |c|
  c.action do |global_options, options, args|
    builder = JsonSchemaBuilder::Writer.new
    builder.write
  end
end

exit GLI.run(ARGV)