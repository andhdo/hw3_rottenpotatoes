# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    
    #debugger
    
    #local_movie = Movie.create({:title => movie.title, :rating => movie.rating, :release_date => movie.release_date})
    #{"title"=>"The Terminator", "rating"=>"R", "release_date"=>"26-Oct-1984"}
    
    #local_Movie = Movie.new()
    #local_Movie.attributes = movie.attributes
    #local_movie.save()
    
    local_movie = Movie.create!(movie)
    
    
  end
  # flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  assert( page.body.index(e1) < page.body.index(e2) , "Sort error")
  
  #flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  
  rating_list.split(",").each do |rating|
    
    local_rating = "ratings_" + rating.gsub(/\s+/, "")
    
    if( uncheck ) 
        uncheck( local_rating)
    else
        check( local_rating)
    end

  end
  
  
  
end

When /I (un)?check all the ratings/ do |uncheck|
  # extract the ratings of the model object
  Movie.all_ratings.each do |local_rating|
    
    local_rating = "ratings_" + local_rating
    
    if( uncheck ) 
        uncheck( local_rating)
    else
        check( local_rating)
    end

  end
  
  
  
end


# search for filters
Then /I should (not )?see items with the following categories: (.*)/ do |not_seen,rating_list|
  
  # strip spaces from array
  
  local_rating_list = rating_list.split(",")
  #rating_list.split(",").each do |rating|
  #local_rating = rating.gsub(/\s+/, "") #rating.strip()
  local_rating_list.collect{ |local_rating|
    local_rating.strip!()
  }
  
  if( not_seen )
    local_rating_list.each do |local_rating|
      page.find(:xpath,"//table[@id='movies']/tbody[count(tr[td='#{local_rating}'])=0]")
      #page.find(:xpath,"count(//table[@id='movies']/tbody/tr[td='#{local_rating}']) = 0")
      #page.find(:xpath,"//table[@id='movies']/tbody/tr[td='#{local_rating}']",:count => 0)
    end
  else
    local_expected_size = Movie.count(:all,:conditions => { :rating => local_rating_list })
    #local_result = page.find(:xpath,"//table[@id='movies']/tbody/tr",:count => local_expected_size )
    
    #test for xpath according cucumber version
    xpath_expression = "//table[@id='movies']/tbody/tr"
    if page.respond_to? :should
      page.should have_xpath(xpath_expression, :count => local_expected_size)
    else
      assert page.has_xpath?(xpath_expression, :count => local_expected_size)
    end
    #debugger
    #page.find(:xpath,"count(//table[@id='movies']/tbody/tr) = #{local_expected_size}") # , :count => local_expected_size )
    #page.should have_xpath("//table[@id='movies']/tbody/tr", :count => local_expected_size)
    
  end
    
  
end

Then /I should see (all|none) of the movies/ do |all_filter|
  
  local_expected_size = 0
  
  if( all_filter == "all" )
    local_expected_size = Movie.count(:all)
  end   


  #test for xpath according cucumber version
  xpath_expression = "//table[@id='movies']/tbody/tr"
  if page.respond_to? :should
    page.should have_xpath(xpath_expression, :count => local_expected_size)
  else
    assert page.has_xpath?(xpath_expression, :count => local_expected_size)
  end

  #page.find(:xpath,"//table[@id='movies']/tbody[count(tr) = #{local_expected_size} ]")

end



