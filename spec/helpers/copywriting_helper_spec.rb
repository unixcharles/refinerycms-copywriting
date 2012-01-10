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
      
      pharse = Refinery::Copywriting::Phrase.where(:name => "test block").first
      pharse.should_not be_nil
      pharse.default.should == block_text
      
      copywriting("test block").should == block_text
    end

    it "it should allow you to set default options with copywriting_options block" do
      copywriting_options({:scope => 'default_scope'}) do
        copywriting("test with default scope")
      end

      Refinery::Copywriting::Phrase.where(:name => "test with default scope").scope.should == 'default_scope'
    end

    it "it should allow you to overwrite the default options set with copywriting_options block" do
      copywriting_options({:scope => 'default_scope'}) do
        copywriting("test without default scope", {:scope => 'without_default_scope'})
      end

      Refinery::Copywriting::Phrase.where(:name => "test without default scope").scope.should == 'without_default_scope'
    end

    it "it should clear the default options after copywriting_options block" do
      copywriting_options({:scope => 'default_scope'}) do
        copywriting("test with default scope")
      end
      copywriting("test outside default scope")

      Refinery::Copywriting::Phrase.where(:name => "test outside default scope").scope.should_not == 'default_scope'
    end

  end
  
end