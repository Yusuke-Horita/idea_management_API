class IdeasController < ApplicationController
  def index
    category_name = params[:category_name]
    unformatted_ideas = Idea.get_ideas(category_name)
    ideas = formatter(unformatted_ideas)
    if ideas.present?
      render json: { data: ideas }
    else
      render status: :not_found, json: { status: 404 }
    end
  end

  def create
    body = idea_params[:body]
    category_name = idea_params[:category_name]
    category_id = Category.get_category_id(category_name)

    idea = Idea.new(body: body, category_id: category_id)
    if idea.save
      render status: :created, json: { status: 201 }
    else
      render status: :unprocessable_entity, json: { status: 422 }
    end
  end

  private

  def idea_params
    params.permit(:category_name, :body)
  end

  def formatter(unformatted_ideas)
    ideas = []
    if unformatted_ideas.present?
      unformatted_ideas.each do |idea|
        hash = {}
        hash[:id] = idea.id
        hash[:category] = idea.category.name
        hash[:body] = idea.body
        ideas << hash
      end
    end
    ideas
  end
end
