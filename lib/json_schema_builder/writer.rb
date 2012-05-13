module JsonSchemaBuilder
  class Writer

    def write
      res = []
      create_file_path
      models_as_hash.each do |model|
        file = File.join('json-schema',"#{model[:title].downcase}.json")
        File.open( file, 'w+' ) {|f| f.write(JSON.pretty_generate(model)) }
        res << "#{file} created"
      end
      puts res.join("\n")
    end

    def models_as_hash
      out = []
      models.each do |model|
        obj = base
        obj[:title] = model.name
        props = {}
        model.columns_hash.each do |name, col|
          prop = {}
          #prop[:name] = Model.human_attribute_name: col.name
          prop[:description] = 'the field description'

          if col.primary
            prop[:identity] = true
            prop[:readonly] = true
          end
          set_type(col.type, prop)
          set_format(col.type, prop)

          prop[:default] = col.default if col.default
          prop[:maxlength] = col.limit if col.type == :string && col.limit
          props[name] = prop
        end
        obj[:properties] = props
        out << obj
      end # models
      out
    end
    # JSON Schema types
    # - string
    # - number  Value MUST be a number, floating point numbers are
    #   allowed.
    # - integer  Value MUST be an integer, no floating point numbers are
    #   allowed.  This is a subset of the number type.
    # - boolean
    def set_type(col_type, hsh)
      if [:date, :datetime, :text].include?(col_type)
        hsh[:type] = :string
      elsif col_type == :decimal
        hsh[:type] = 'number'
      else
        hsh[:type] = col_type
      end
    end

    def set_format(col_type, hsh)
      hsh[:format] = 'date-time' if col_type == :datetime
      hsh[:format] = 'date' if col_type == :date
    end

    def base
      hsh = {}
      hsh[:type] = 'object'
      hsh[:title] = ''
      hsh[:description] = 'object'
      hsh[:properties] = {}
      hsh[:links] = []
      hsh
    end

    def models
      model_names = Module.constants.select { |c| (eval "#{c}").is_a?(Class) && (eval "#{c}") < ActiveRecord::Base }
      model_names.map{|i| "#{i}".constantize}
    end

    def create_file_path
      FileUtils.mkdir('json-schema') unless File.exists?('json-schema')
    end
  end
end