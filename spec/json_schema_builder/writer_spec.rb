require 'spec_helper'

describe JsonSchemaBuilder::Writer do

  context 'in general' do
    before :each do
      @writer = JsonSchemaBuilder::Writer.new
    end
    it 'should get model_path' do
      @writer.model_path.should == "#{Dir.pwd}/app/models/**/*.rb"
    end

    it 'should set model_path' do
      path = 'some/model-folder/*.*.rb'
      @writer.model_path = path
      @writer.model_path.should == path
    end

    it 'should get models' do
      @writer.models.should include(User)
    end
  end

  context 'file writing' do
    before :each do
      @writer = JsonSchemaBuilder::Writer.new
      @writer.out_path = test_out_path
      @writer.model_path = File.join( File.expand_path( __FILE__), '../fixtures/*.rb')
      @writer.write
      @file_path =  File.join(test_out_path, 'user.json')
    end

    it 'should write file' do
      File.exist?( @file_path ).should be
      File.delete @file_path
    end

    it 'should write valid json' do
      hsh = JSON.parse( File.read @file_path)
      hsh['type'].should == 'object'
      hsh['title'].should == 'User'
      field_names = hsh['properties'].keys
      field_names.should include 'id', 'number', 'birthday', 'is_admin', 'notes'
    end
  end

end