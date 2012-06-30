namespace :schema do
  rails_env = ENV['RAILS_ENV'] || 'development'
  desc "create schema files in json-schema/*.json"
  task :build do |t,args|
    if defined?(Rails) && Rails.respond_to?(:application)
      # Rails 3
      Rails.application.initialize! #eager_load!
    elsif defined?(Rails::Initializer)
      # Rails 2.3
      $rails_rake_task = false
      Rails::Initializer.run :load_application_classes
    end
    builder = SchemaBuilder::Writer.new
    builder.write
  end
end