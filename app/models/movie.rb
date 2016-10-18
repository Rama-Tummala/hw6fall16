class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
 class Movie::InvalidKeyError < StandardError ; end
  
 def self.find_in_tmdb(title)
   Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
   begin
   puts title
  if title.empty?
   return [].as_json
  end
  
    # movie[:tmdb_id => "",:title =>"", :rating => "", :release_date => ""] =Tmdb::Movie.find(string)
      movie =Tmdb::Movie.find(title)
      movie.as_json
      puts movie
     movie.as_json
     
   rescue NoMethodError => tmdb_gem_exception
    if Tmdb::Api.response['code'] == '401'
        raise Movie::InvalidKeyError, 'Invalid API key'
    else
      raise tmdb_gem_exception
    end
  # end
   end
 end
 
 def self.create_from_tmdb(movie_id)
    puts movie_id
Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
movie_params = Tmdb::Movie.detail(movie_id)
movie = Movie.new
movie.title = movie_params["title"]
movie.rating= "R"
movie.release_date = movie_params["release_date"]
movie.save


 end
 
end
