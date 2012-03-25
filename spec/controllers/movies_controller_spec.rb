require 'spec_helper'
 
describe MoviesController do

  describe 'finding movies with similar Director ' do
  fixtures :movies

    it 'should call the model method that performs movie search by director' do

      Movie.should_receive(:find_in_mvdb)
      post :find_similar_movies, {:id => 1}
  
    end
    it 'should select the Search Results template for rendering' do
      Movie.stub(:find_in_mvdb)
      post :find_similar_movies, {:id => 1}
      response.should render_template('find_similar_movies')
    end
    it 'should make the TMDb search results available to that template' do
      fake_results = [mock('Movie'), mock('Movie')]
      Movie.stub(:find_in_mvdb).and_return(fake_results)
      post :find_similar_movies, {:id => 1}
    # look for controller method to assign @movies
      assigns(:movies).should == fake_results
    end
    it 'should return movies with same director' do
      
      movs = Movie.find_in_mvdb(movies(:one).director)
      movs.each do |mov|
        mov.director.should == movies(:one).director
      end
    end
    it 'should return an empty movie if there is no director' do
      post :find_similar_movies, {:id => 4}
      assigns(:movies).should ==  nil
    end
  end
end
