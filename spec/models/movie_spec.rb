require 'spec_helper'
require File.expand_path("../../factories/movie", __FILE__) 
describe Movie do

  describe 'finding movies by Director ' do
    it 'should include movies' do
      m1 = factorymovie.build(:movie, :title => 'Star Wars',:rating => 'PG', :director => 'George Lucas', :release_date => '1977-05-25')
      m2 = factorymovie.build(:movie, :title => 'Blade Runner',:rating => 'PG', :director => 'Ridley Scott', :release_date => '1982-06-25')
      m3 = factorymovie.build(:movie, :title => 'THX-1138',:rating => 'R', :director => 'George Lucas', :release_date => '1971-03-11')
    end
    it 'should return all movies with a given director' do
    
      result = Movie.find_in_mvdb("George Lucas")
      "THX-1138".should == result[0].title || result[1].title
    end
  end
end

