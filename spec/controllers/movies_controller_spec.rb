require 'spec_helper'
require 'rails_helper'

describe MoviesController do
  describe 'searching TMDb' do
   it 'should call the model method that performs TMDb search' do
     # fake_results = Array(Hash.new(:tmdb_id => "",:title =>"", :rating => "", :release_date => ""))
     fake_results = [double('movie1'), double('movie2')]
      expect(Movie).to receive(:find_in_tmdb).with('Ted').
        and_return(fake_results)
      post :search_tmdb, {:search_terms => 'Ted'}
    end
    it 'should select the Search Results template for rendering' do
      allow(Movie).to receive(:find_in_tmdb)
      post :search_tmdb, {:Search => 'Ted'}
      expect(response).to render_template('search_tmdb')
    end  
    it 'should redirect to the home page for a non-existing movie' do
      allow(Movie).to receive(:find_in_tmdb).with('xvxvx').and_return ([])
      post :search_tmdb, {:search_terms => 'xvxvx'}
      expect(response).to equal('redirect to movies_path')
    end
    it 'should redirect to the home page for a non-existing movie' do
      allow(Movie).to receive(:find_in_tmdb).with('xvxvx').and_return ([])
      post :search_tmdb, {:search_terms => 'xvxvx'}
      expect(flash[:warning]).to equal('No matching  movies were found on Tmdb.')
    end
    it 'should flash a message for a search without giving title' do
      allow(Movie).to receive(:find_in_tmdb).with("")
      post :search_tmdb, {:search_terms => ""}
      expect(flash[:warning]).to equal('Invalid search term')
    end
    
    it 'should make the TMDb search results available to that template' do
      fake_results = [double('Movie'), double('Movie')]
      allow(Movie).to receive(:find_in_tmdb).and_return (fake_results)
      post :search_tmdb, {:search_terms => 'Ted'}
      expect(assigns(:movies)).to eq(fake_results)
    end 
  end
end
