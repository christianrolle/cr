class ArticlesController < ApplicationController
  def index
    @articles = Article.published.by_publishing.includes(:tags).without_text.all
  end

  def show
    @article = Article.find_by_slug params[:id]
  end
end
