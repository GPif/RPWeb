### THEN ###

Then /^I should be on the "(.*?)" page$/ do |page|
	put current_path
	current_path.should == eval("#{page}_path")
end

