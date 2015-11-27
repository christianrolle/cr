class ArticlesController < ApplicationController
  def index
    @articles = Article.localized(I18n.locale).published.includes(:tags)
                  .by_publishing
  end

  def show
    @article = Article.find_by_slug params[:id]
  end
end
