# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
end
   #assert false, "Unimplmemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  regexp  =  Regexp.new ".*#{e1}.*#{e2}.*"
  page.body.should =~ regexp
  #assert false, "Unimplmemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(/,\s*/).each do |r|
   if r =~ /\w/
    uncheck == "un" ? uncheck("ratings_" + r) : check("ratings_" + r) 
   end
  end
end

Then /I should see all movies/ do
   rows =  Movie.find(:all).length
   count = page.all('#movies tr').size
   assert rows == count -1
end

When /I select no ratings/ do
 #When I unheck the following ratings: R, PG, PG-13, G
   uncheck("ratings_R"); uncheck("ratings_PG"); uncheck("ratings_PG-13"); uncheck("ratings_G");
  visit path_to("the RottenPotatoes home page")
end

Then /I should see no movies/ do
  count = page.all('#movies tr').size 
  assert count == 1
end

Then /the director of "([^"]*)" should be "([^"]*)"/ do |title, director|
  movie = Movie.find_by_title(title)
  assert movie.director == director
end

