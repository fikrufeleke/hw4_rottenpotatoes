# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
end
   #assert false, "Unimplmemented"
end

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

When /I go to the edit page for "([^"]*)"/ do |title|
   movie = Movie.find_by_title(title)
   id = Movie.id
   visit path_to("the details page for #{id}")
   click_button("Edit")
end

Given /I am on the details page for "([^"]*)"/ do |title|
   movie = Movie.find_by_title(title)
   id = Movie.id
   visit path_to("the details page for #{id}")
end

Then /the director of "([^"]*)" should be "([^"]*)"/ do |title, director|
  movie = Movie.find_by_title(title)
  assert movie.director == director
end

Then /I should be on the Similar Movies page for "([^"]*)"/ do |page|
  current_path = URI.parse(current_url).path
  movie = Movie.find_by_title(Title)
  Id = Movie.id
  assert current_path == '/movies/Id'
end
And /I should see "('[^"']*') has no director info"/ do |title|
  movie = Movie.find_by_title(title)
  assert movie.director == ""
end
