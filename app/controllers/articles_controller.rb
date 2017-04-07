# Controller for articles
class ArticlesController < ApplicationController
=begin
  def index
    @articles = Article.published
                       .tagged(params[:tag_slug])
                       .search(params[:search])
                       .preload(:tags, :translated_article)
                       .by_publishing
  end
=end
  def index
    @articles = TranslatedArticle.by_publishing
                       .tagged(params[:tag_slug])
                       .search(params[:search])
                       .preload(:tags)
  end
=begin
  def show
    @article = Article.preload(:tags)
                      .find_by_slug(params[:slug])
    alternate_to alternate_url(@article)
  end
=end
  def show
    @article = TranslatedArticle.preload(:tags)
                                .find(params[:slug])
  end

  private

  def alternate_url(article)
    url_for params.merge(locale: @locale.secondary, slug: article.slug)
  end
end
