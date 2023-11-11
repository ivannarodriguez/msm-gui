class ActorsController < ApplicationController
  def update
    m_id = params.fetch("the_name")

    matching_records = Actor.where({:name => m_id})
    the_actor = matching_records.at(0)

    the_actor.name = params.fetch("the_name")
    the_actor.dob = params.fetch("the_dob")
    the_actor.bio = params.fetch("the_bio")
    the_actor.image = params.fetch("the_image")

    the_actor.save

    redirect_to("/actors/#{the_actor.id}")
  end

  
  def create
    # params hash looks like this:
    # {"the_title"=>"1", "the_year"=>"2", "the_duration"=>"3", "the_description"=>"4", "the_image"=>"5", "the_director_id"=>"6"}

    m = Actor.new
    m.name = params.fetch("the_name")
    m.dob = params.fetch("the_dob")
    m.bio = params.fetch("the_bio")
    m.image = params.fetch("the_image")
 

    m.save

    redirect_to("/actors")

    # Retrieve the user's inputs from params
    # Create a record in the movie table
    # Populate each column with the user input
    # Save

    # Redirect the user back to the /movies URL
  end

  def destroy
    the_id = params.fetch("an_id")
    matching_records = Actor.where({:id => the_id})
    the_actor = matching_records.at(0)
    the_actor.destroy
    redirect_to("/actors")
  end

  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end
end
