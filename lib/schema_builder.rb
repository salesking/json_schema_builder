require 'json'
require 'schema_builder/version'
require 'schema_builder/writer'
require 'schema_builder/railtie' if defined? ::Rails::Railtie
#Dir["schema_builder/tasks/*.rake"].each { |ext| load ext } if defined?(Rake)

module SchemaBuilder;end
