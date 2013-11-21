Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
     Movie.create!(movie)
  end
    assert movies_table.hashes.size == Movie.all.count
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  titles = page.all("table#movies tbody tr td[1]").map {|t| t.text}
  assert titles.index(e1) < titles.index(e2) 
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list| 
  
    ratings = rating_list.split(',')
    ratings.each do |x|
      if uncheck
        uncheck("ratings[#{x}]")
      else
        check("ratings[#{x}]")
      end
     end
end

Then /I should see all of the movies/ do
  movies = Movie.all
  if movies.size == 10 #There are 10 movies in our test data, loop through and check if they are all there
    movies.each do |movie|
      assert page.body =~ /#{movie.title}/m, "#{movie.title} is not showing up"
    end
  else
    false
  end
end

Then /I should not see any movies/ do
  movies = Movie.all
  movies.each do |movie|
    assert true unless page.body =~ /#{movie.title}/m  #Make sure there are no titles on the page
  end
end

