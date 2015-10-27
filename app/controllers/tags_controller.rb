class TagsController < ApplicationController
  def index
    @tags = Tag.search(params[:search]).ordered.all
    render json: @tags
  end
end
