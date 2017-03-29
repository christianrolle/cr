# Controller for articles
class ArticlesController < ApplicationController
  def index
    @articles = Article.published
                       .tagged(params[:tag_slug])
                       .search(params[:search])
                       .preload(:tags, :translated_article)
                       .by_publishing
  end

  def show
    @article = Article.preload(:tags)
                      .find_by_slug(params[:slug])
    alternate_to alternate_url(@article)
  end

  private

  def alternate_url(article)
    url_for params.merge(locale: @locale.secondary, slug: article.slug)
  end
end
