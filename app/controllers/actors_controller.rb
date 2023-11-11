class ActorsController < ApplicationController
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

  def create
    a = Actor.new
    a.name = params["the_name"]
    a.dob = params["the_dob"]
    a.bio = params["the_bio"]
    a.image = params["the_image"]

    a.save

    redirect_to("/actors")
  end

  def destroy
    the_id = params["an_id"]

    matching_records = Actor.where({:id => the_id})

    the_actor = matching_records[0]

    the_actor.destroy
    
    redirect_to("/actors")
  end

  def update
    id = params["the_id"]

    matching_records = Actor.where({:name => id})
    actor = matching_records[0]

    actor.name = params["the_name"]
    actor.dob = params["the_dob"]
    actor.bio = params["the_bio"]
    actor.image = params["the_image"]

    actor.save

    redirect_to("/actors/#{actor.id}")
  end
end
