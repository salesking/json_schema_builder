module SchemaBuilder
  class Railtie < ::Rails::Railtie
    rake_tasks do
      require 'schema_builder/tasks'
    end
  end
end