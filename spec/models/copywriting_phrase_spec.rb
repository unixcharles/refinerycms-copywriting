require 'spec_helper'

describe CopywritingPhrase do

  context "validations" do
    
    it "rejects empty name" do
      copy = CopywritingPhrase.new
      copy.save.should be_false
    end
    
  end

  context "for" do

    it "should return the default string if value is not set" do
      CopywritingPhrase.for('name', {:scope => 'scope', :default => 'default'}).should == 'default'
    end

    it "should not duplicate copywriting phrases" do
      2.times { CopywritingPhrase.for('name', {:scope => 'scope', :default => 'default'}) }
      CopywritingPhrase.where(:name => 'name').count.should == 1
    end

    it "should return the string the value once its set" do
      CopywritingPhrase.for('name', {:scope => 'scope', :default => 'default'}).should == 'default'
      copy = CopywritingPhrase.where(:name => 'name').first
      copy.value = 'updated!'
      copy.save

      CopywritingPhrase.for('name', {:scope => 'scope', :default => 'default'}).should == 'updated!'
    end
    
    it "should save options" do
      CopywritingPhrase.for('name', {:scope => 'scope', :default => 'default', :phrase_type => 'wysiwyg'})

      phrase = CopywritingPhrase.where(:name => 'name').first

      phrase.name.should == "name"
      phrase.phrase_type.should == "wysiwyg"
      phrase.scope.should == "scope"
      phrase.default.should == "default"
      phrase.value.should == nil
    end
    
    it "should have defaults options" do
      name = "test_defaults"
      CopywritingPhrase.for(name)
      phrase = CopywritingPhrase.where(:name => name).first

      phrase.name.should == name
      phrase.phrase_type.should == "text"
      phrase.scope.should == "default"
      phrase.default.should == nil
      phrase.value.should == nil
    end
    
    it "should allow you to scope to a page" do
      page = Page.create(:title => "test page")

      name = "test_page"
      CopywritingPhrase.for(name, :page => page)
      phrase = CopywritingPhrase.where(:name => name).first
      
      phrase.page_id.should == page.id
    end

    it "should allow you to scope to a page_id" do
      name = "test_page_id"
      CopywritingPhrase.for(name, :page_id => 22)
      phrase = CopywritingPhrase.where(:name => name).first
      
      phrase.page_id.should == 22
    end

  end

end