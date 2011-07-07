require 'spec_helper'

describe CopywritingHelper do

  context "usage" do
    
    it "it should create using defaults" do
      copywriting("test").should == nil
    end
    
    it "it should allow you to set options" do
      copywriting("test", {:scope => 'scope', :default => 'default', :phrase_type => 'wysiwyg'}).should == 'default'
      copywriting("test two", {:default => "test just default"}).should == "test just default"
    end

    it "it should allow you to set the value using a block" do
      block_text = "this is a block"
      
      result = copywriting("test block") { block_text }
      
      pharse = CopywritingPhrase.where(:name => "test block").first
      pharse.should_not be_nil
      pharse.default.should == block_text
      
      copywriting("test block").should == block_text
    end
    
  end
  
end