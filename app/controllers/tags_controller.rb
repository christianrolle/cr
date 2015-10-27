class TagsController < ApplicationController
  def index
    @tags = Tag.search(params[:search]).all
    render json: @tags
  end
end
