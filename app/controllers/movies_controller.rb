class MoviesController < ApplicationController 
  def index
    @director = Director.find(params[:director_id])
    @movies = @director.movies
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
