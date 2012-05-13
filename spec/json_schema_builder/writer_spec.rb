require 'spec_helper'

describe JsonSchemaBuilder::Writer do

  it "should get models" do
    a = JsonSchemaBuilder::Writer.new
    a.write.should == 'write real specs .. check spec folder til than'
  end

end