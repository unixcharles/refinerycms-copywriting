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
      CopywritingPhrase.for('name', 'scope', 'default', nil).should == 'default'
    end

    it "should not duplicate copywriting phrases" do
      2.times { CopywritingPhrase.for('name', 'scope', 'default', nil) }
      CopywritingPhrase.where(:name => 'name').count.should == 1
    end

    it "should return the string the value once its set" do
      CopywritingPhrase.for('name', 'scope', 'default', nil).should == 'default'
      copy = CopywritingPhrase.where(:name => 'name').first
      copy.value = 'updated!'
      copy.save

      CopywritingPhrase.for('name', 'scope', 'default', nil).should == 'updated!'
    end

  end

end