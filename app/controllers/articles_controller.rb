class ArticlesController < ApplicationController
  def index
    @articles = Article.published.all
  end

  def show
    @article = Article.find_by_slug params[:id]
  end
end
