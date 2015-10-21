require 'spec_helper'

describe Refinery::Copywriting::CopywritingHelper, type: :helper do

  context "usage" do

    it "it should create using defaults" do
      expect(copywriting("test")).to be_nil
    end

    it "it should allow you to set options" do
      expect(copywriting("test", {:scope => 'scope', :default => 'default', :phrase_type => 'wysiwyg'})).to eq('default')
      expect(copywriting("test two", {:default => "test just default"})).to eq('test just default')
    end

    it "it should allow you to set the value using a block" do
      block_text = "this is a block"

      result = copywriting("test block") { block_text }

      phrase = Refinery::Copywriting::Phrase.where(:name => "test block").first
      expect(phrase).to_not be_nil
      expect(phrase.default).to eq(block_text)

      expect(copywriting("test block")).to eq(block_text)
    end

    it "it should allow you to set default options with copywriting_options block" do
      copywriting_options({:scope => 'default_scope'}) do
        copywriting("test with default scope")
      end

      expect(Refinery::Copywriting::Phrase.where(:name => "test with default scope").first.scope).to eq('default_scope')
    end

    it "it should allow you to overwrite the default options set with copywriting_options block" do
      copywriting_options({:scope => 'default_scope'}) do
        copywriting("test without default scope", {:scope => 'without_default_scope'})
      end

      expect(Refinery::Copywriting::Phrase.where(:name => "test without default scope").first.scope).to eq('without_default_scope')
    end

    it "it should clear the default options after copywriting_options block" do
      copywriting_options({:scope => 'default_scope'}) do
        copywriting("test with default scope")
      end
      copywriting("test outside default scope")

      expect(Refinery::Copywriting::Phrase.where(:name => "test outside default scope").first.scope).to_not eq('default_scope')
    end

  end

end
