class IdeasController < ApplicationController
	def index
    category_name = params[:category_name]
    ideas = Idea.get_ideas(category_name)
		if ideas.present?
			render json: { data: ideas }
		else
			render status: 404, json: { status: 404 }
		end
	end

	def create
    body = idea_params[:body]
    category_name = idea_params[:category_name]
    category_id = Category.get_category_id(category_name)

		idea = Idea.new(body: body, category_id: category_id)
		if idea.save
			render status: 201, json: { status: 201 }
		else
			render status: 422, json: { status: 422 }
		end
	end

	private

	def idea_params
		params.permit(:category_name, :body)
	end
end
