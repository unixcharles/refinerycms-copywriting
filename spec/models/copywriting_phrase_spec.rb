require 'spec_helper'

describe Refinery::Copywriting::Phrase, type: :model do

  context "validations" do

    it "rejects empty name" do
      copy = Refinery::Copywriting::Phrase.new
      expect(copy.save).to be_falsey
    end

  end

  context "for" do

    it "should return the default string if value is not set" do
      expect(Refinery::Copywriting::Phrase.for('name', {:scope => 'scope', :default => 'default'})).to eq('default')
    end

    it "should not duplicate copywriting phrases" do
      2.times { Refinery::Copywriting::Phrase.for('name', {:scope => 'scope', :default => 'default'}) }
      expect(Refinery::Copywriting::Phrase.where(:name => 'name').count).to eq(1)
    end

    it "differentiates records by scope" do
      2.times {|n| Refinery::Copywriting::Phrase.for('name', {:scope => "scope#{n}", :default => 'default'}) }
      expect(Refinery::Copywriting::Phrase.where(:name => 'name').pluck(:scope)).to match_array(['scope0', 'scope1'])
    end

    it "should return the string the value once it is set" do
      expect(Refinery::Copywriting::Phrase.for('name', {:scope => 'scope', :default => 'default'})).to eq('default')
      copy = Refinery::Copywriting::Phrase.where(:name => 'name').first
      copy.value = 'updated!'
      copy.save

      expect(Refinery::Copywriting::Phrase.for('name', {:scope => 'scope', :default => 'default'})).to eq('updated!')
    end

    it "should save options" do
      Refinery::Copywriting::Phrase.for('name', {:scope => 'scope', :default => 'default', :phrase_type => 'wysiwyg'})

      phrase = Refinery::Copywriting::Phrase.where(:name => 'name').first

      expect(phrase.name).to eq('name')
      expect(phrase.phrase_type).to eq('wysiwyg')
      expect(phrase.scope).to eq('scope')
      expect(phrase.default).to eq('default')
      expect(phrase.value).to be_nil
    end

    it "should have defaults options" do
      name = "test_defaults"
      Refinery::Copywriting::Phrase.for(name)
      phrase = Refinery::Copywriting::Phrase.where(:name => name).first

      expect(phrase.name).to eq(name)
      expect(phrase.phrase_type).to eq('text')
      expect(phrase.scope).to eq('default')
      expect(phrase.default).to be_nil
      expect(phrase.value).to be_nil
    end

    it "should allow you to scope to a page" do
      page = Refinery::Page.create(:title => "test page")

      name = "test_page"
      Refinery::Copywriting::Phrase.for(name, :page => page)
      phrase = Refinery::Copywriting::Phrase.where(:name => name).first

      expect(phrase.page_id).to eq(page.id)
    end

    it "should allow you to scope to a page_id" do
      name = "test_page_id"
      Refinery::Copywriting::Phrase.for(name, :page_id => 22)
      phrase = Refinery::Copywriting::Phrase.where(:name => name).first

      expect(phrase.page_id).to eq(22)
    end

  end

end
