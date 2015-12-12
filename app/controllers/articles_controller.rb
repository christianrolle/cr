class ArticlesController < ApplicationController
  def index
    @articles = Article.localized(I18n.locale).published.includes(:tags)
                  .by_publishing
  end

  def show
    article = LocalizedArticle.find_by_slug params[:id]
    @localized_article = LocalizedArticle.new article, locale
  end
end
