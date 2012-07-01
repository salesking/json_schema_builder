namespace :schema do

  desc "create JSON schema files in json-schema/*.json"
  task :build do |t,args|
    if defined?(Rails) && Rails.respond_to?(:application)
      Rails.application.initialize!
    else
      puts "== Hiccup ==\n"
      puts "Sorry cannot find a Rails 3.+ app.\n You can still write a schema by hand .. it's not that difficult.\n Btw. you should move to Rails 3 anyway!"
      next
    end
    builder = SchemaBuilder::Writer.new
    builder.routes = Rails.application.routes.routes.routes
    builder.write
  end
end