class Admin::TagsController < ApplicationController
  def index
    article = Article.find params[:article_id]
    @tags = Tag.search(params[:search]).excluding(article.tag_ids).ordered.all
    render json: @tags.as_json(only: [:id, :name])
  end
end
