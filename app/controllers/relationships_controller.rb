class RelationshipsController < ApplicationController

  def create
    @relationship = Relationship.create(relationship_params)
    if @relationship.valid?
      render json: @relationship
    else
      render json: @relationship.errors, status: :unprocessable_entity
      p @relationship.errors
    end
  end

  def update_relationship
    @relationship = Relationship.find(params[:id])
    @relationship.update(relationship_params)
    render json: @relationship
  end

# mentors
  def pending_mentors
    @mentors = []
    Relationship.find_each do |relationship|
      if relationship.developer_id == current_user.id && relationship.status == 1
        @mentors << relationship.as_json(:include => :mentor)
      end
    end
    render json: @mentors
  end

  def pending_mentor_ids
    @mentors = []
    Relationship.find_each do |relationship|
      if relationship.developer_id == current_user.id && relationship.status == 1
        @mentors << relationship.mentor_id
      end
    end
    render json: @mentors
  end

  def mentors_ids
    @mentors = []
    Relationship.find_each do |relationship|
      if relationship.developer_id == current_user.id && relationship.status == 2
        @mentors << relationship.mentor_id
      end
    end
    render json: @mentors
  end

  def my_mentors
    @mentors = []
    Relationship.find_each do |relationship|
      if relationship.developer_id == params[:id].to_i && relationship.status == 2
        @mentors << relationship.as_json(:include => :mentor)
      end
    end
    render json: @mentors
  end


# developer
  def pending_developers
    @mentors = []
    Relationship.find_each do |relationship|
      if relationship.mentor_id == current_user.id && relationship.status == 1
        @mentors << relationship.as_json(:include => :developer)
      end
    end
    render json: @mentors
  end

  def developers_ids
    @mentors = []
    Relationship.find_each do |relationship|
      if relationship.mentor_id == current_user.id && relationship.status == 2
        @mentors << relationship.developer_id
      end
    end
    render json: @mentors
  end

  def pending_developer_ids
    @mentors = []
    Relationship.find_each do |relationship|
      if relationship.mentor_id == current_user.id && relationship.status == 1
        @mentors << relationship.developer_id
      end
    end
    render json: @mentors
  end

  def my_developers
    @mentors = []
    Relationship.find_each do |relationship|
      if relationship.mentor_id == params[:id].to_i && relationship.status == 2
        @mentors << relationship.as_json(include: :developer)
      end
    end
    render json: @mentors
  end

  def relationship_params
    params.require(:relationship).permit(:mentor_id, :developer_id, :status, :sender_id)
  end
end
