Given /^I have no copywritings$/ do
  Refinery::Copywriting::Phrase.delete_all
end

Given /^I (only )?have copywritings titled "?([^\"]*)"?$/ do |only, titles|
  Refinery::Copywriting::Phrase.delete_all if only
  titles.split(', ').each do |title|
    Refinery::Copywriting::Phrase.create(:name => title)
  end
end

Then /^I should have ([0-9]+) copywritings?$/ do |count|
  Refinery::Copywriting::Phrase.count.should == count.to_i
end
