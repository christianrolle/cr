class ArticlesController < ApplicationController
  def index
    @articles = TranslatedArticle.localized(locale)
                                  .search(params[:search])
                                  .preload(:tags)
                                  .by_publishing
  end

  def show
    @article = TranslatedArticle.find_by_slug params[:id]
  end
end
