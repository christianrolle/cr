class ArticlesController < ApplicationController

  def index
    @articles = Article.published
                        .tagged(params[:tag_slug])
                        .search_localized(params[:search], locale)
                        .preload(:tags)
                        .by_publishing
  end

  def show
    #@article = TranslatedArticle.find_by_slug params[:slug]
    @article = Article.find_by_slug params[:slug]
    alternate_to alternate_url(@article)
  end

  private

  def alternate_url article
    url_for(params.merge({ locale: @locale.secondary, slug: @article.slug }))
  end

end
