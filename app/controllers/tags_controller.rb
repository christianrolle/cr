# Controller for article tags
class TagsController < ApplicationController
  def index
    @tags = Tag.search(params[:search])
               .ordered
               .all
    render json: @tags.as_json(only: %i(id name))
  end
end
