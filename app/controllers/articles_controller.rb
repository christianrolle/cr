class ArticlesController < ApplicationController
  def index
    @articles = Article.localized(locale).search(params[:search]).by_publishing
  end

  def show
    @article = Article.find_by_slug params[:id]
  end
end
