namespace :schema do

  desc "create JSON schema files in json-schema/*.json"
  task :build do |t,args|
    if defined?(Rails) && Rails.respond_to?(:application)
      Rails.application.initialize!
    elseif defined?(Rails::Initializer)
      # Rails 2.3
      puts "== Hiccup ==\n"
      puts "Sorry Rails < 3 is not supported\n You can still write a schema by hand .. it's not that difficult.\n Btw. you should move to Rails 3 anyway!"
      next
    end
    builder = SchemaBuilder::Writer.new
    builder.routes = Rails.application.routes.routes.routes
    builder.write
  end
end