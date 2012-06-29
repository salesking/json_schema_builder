module JsonSchemaBuilder

  # Create json schema files for each model in
  # Rails.root/json-schema/modelName.json
  # @example
  #   builder = JsonSchemaBuilder::Writer.new
  #   builder.write
  class Writer

    def write
      res = []
      create_file_path
      models_as_hash.each do |model|
        file = File.join( out_path, "#{model['title'].downcase}.json")
        File.open( file, 'w+' ) {|f| f.write(JSON.pretty_generate(model)) }
        res << "#{file} created"
      end
      puts res.join("\n")
    end

    def models_as_hash
      out = []
      models.each do |model|
        obj = base_hash
        obj['title'] = model.name
        props = {}
        model.columns_hash.each do |name, col|
          prop = {}
          prop['description'] = 'the field description'
          prop['identity'] = true if col.primary
          set_readonly(name,prop)
          set_type(col.type, prop)
          set_format(col.type, prop)

          prop['default'] = col.default if col.default
          prop['maxlength'] = col.limit if col.type == :string && col.limit
          props["#{name}"] = prop
        end
        obj['properties'] = props
        out << obj
      end # models
      out
    end

    #@return [Hash{String=>Mixed}] base json schema object hash
    def base_hash
      hsh = {}
      hsh['type'] = 'object'
      hsh['title'] = ''
      hsh['description'] = 'object'
      hsh['properties'] = {}
      hsh['links'] = []
      hsh
    end

    # @return [Array<ActiveRecord::Base>] AR::Base descendant models
    def models
      # require so they are in module scope
      Dir.glob( model_path ).each { |file| require file }
      model_names = Module.constants.select { |c| (eval "#{c}").is_a?(Class) && (eval "#{c}") < ::ActiveRecord::Base }
      model_names.map{|i| "#{i}".constantize}
    end

    def create_file_path
      FileUtils.mkdir_p(out_path) unless File.exists?(out_path)
    end

    def model_path
      @model_path ||= File.join( Dir.pwd, 'app/models', '**/*.rb')
    end

    # Set the model path
    # @param [String] path or file or pattern like models/**/*.rb
    def model_path=(path)
      @model_path = path
    end

    # Path to write json files
    def out_path
      @out_path ||= File.join( Dir.pwd, 'json-schema')
    end

    # @param [String] path to json schema files
    def out_path=(path)
      @out_path = path
    end

    private

    # Set the type of the field property
    # JSON Schema types
    # - string
    # - number  Value MUST be a number, floating point numbers are
    #   allowed.
    # - integer  Value MUST be an integer, no floating point numbers are
    #   allowed.  This is a subset of the number type.
    # - boolean
    # @param [Symbol] col_type derived from ActiveRecord model
    # @param [Hash{String=>String}] hsh with field properties
    def set_type(col_type, hsh)
      hsh['type'] = if [:date, :datetime, :text].include?(col_type)
                       'string'
                    elsif col_type == :decimal
                      'number'
                    else
                      "#{col_type}"
                    end
    end

    # Set the format for a field property
    # @param [Symbol] col_type derived from ActiveRecord model
    # @param [Hash{String=>String}] hsh with field properties
    def set_format(col_type, hsh)
      hsh['format'] = if col_type == :datetime
                        'date-time'
                      elsif col_type == :date
                        'date'
                      end
    end

    # Set a field to read-only
    # @param [String] col_name derived from ActiveRecord model
    # @param [Hash{String=>String}] hsh with field properties
    def set_readonly(col_name, hsh)
      hsh['readonly'] = true if ['created_at', 'updated_at', 'id'].include?(col_name)
    end
  end
end