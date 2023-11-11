class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def update
    # Get the ID out of params
    m_id = params.fetch("the_id")

    # Look up the existing record
    matching_records = Movie.where({ :id => m_id })
    the_movie = matching_records.at(0)

    # Overwrite each column with the values from user inputs
    the_movie.title = params.fetch("the_title")
    the_movie.year = params.fetch("the_year")
    the_movie.duration = params.fetch("the_duration")
    the_movie.description = params.fetch("the_description")
    the_movie.image = params.fetch("the_image")
    the_movie.director_id = params.fetch("the_director_id")

    # Save

    the_movie.save

    # Redirect to the movie details page
    redirect_to("/movies/#{the_movie.id}")
  end

  def create
    # retreive users input from params
    # add record to movie table
    # populate each col with user input
    # save
    # redirect to /movies rather than rendering a template

    m = Movie.new
    # m's attributes shoudl correspond to the schema in db/migrate
    m.title = params["title"]
    m.year = params["year"]
    m.duration = params["duration"]
    m.description = params["description"]
    m.image = params["image"]
    m.director_id = params["director_id"]

    m.save

    # instead of rendering we redirect
    redirect_to("/movies")
  end

  def destroy
    the_id = params.fetch("an_id")

    matching_records = Movie.where({ :id => the_id })

    the_movie = matching_records.at(0)

    the_movie.destroy

    redirect_to("/movies")
  end
end
