class ArticlesController < ApplicationController
  def index
    @articles = Article.published.by_publishing.includes(:tags).all
  end

  def show
    @article = Article.find_by_slug params[:id]
  end
end
