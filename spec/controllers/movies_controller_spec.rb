require 'spec_helper'
 
describe MoviesController do

  describe 'finding movies with similar Director ' do

    it 'should call the model method that performs movie search by director' do

      Movie.should_receive(:find_in_mvdb).with('Ridley Scott')
      post :find_similar_movies, {:director_name => 'Ridley Scott'}
  
    end
    it 'should select the Search Results template for rendering' do
      Movie.stub(:find_in_mvdb)
      post :find_similar_movies, {:director_name => 'Ridley Scott'}
      response.should render_template('find_similar_movies')
    end
    it 'should make the TMDb search results available to that template' do
      fake_results = [mock('Movie'), mock('Movie')]
      Movie.stub(:find_in_mvdb).and_return(fake_results)
      post :find_similar_movies, {:director_name => 'Ridley Scott'}
    # look for controller method to assign @movies
      assigns(:movies).should == fake_results
    end
    it 'should return an empty movie with notice if there is no director' do
      post :find_similar_movies, {:director_name => ""}
      assigns(:movies).should == nil
    end
  end
end
