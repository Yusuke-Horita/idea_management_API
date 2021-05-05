class IdeasController < ApplicationController
	def index
    category_name = params[:category_name]
    ideas = Idea.get_ideas(category_name)
		render json: { data: ideas }
	end

	def create
    body = idea_params[:body]
    category_name = idea_params[:category_name]
    category_id = Category.get_category_id(category_name)

		idea = Idea.new(body: body, category_id: category_id)
		if idea.save
			render json: { status: 201, data: idea }
		else
			render json: { status: 422, data: idea.errors }
		end
	end

	private

end
