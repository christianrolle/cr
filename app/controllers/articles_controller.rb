class ArticlesController < ApplicationController

  def index
    @articles = Article.published
                        .tagged(params[:tag_slug])
                        .search_localized(params[:search], locale)
                        .preload(:tags)
                        .by_publishing
  end

  def show
    @article = TranslatedArticle.find_by_slug params[:slug]
    alternate_to alternate_url(@article)
  end

  private

  def alternate_url article
    alternate_slug = alternate_slug(article)
    return if alternate_slug.nil?
    url_for(params.merge({ locale: @locale.secondary, id: alternate_slug }))
  end

  def alternate_slug article
    article.translated_articles.localized(@locale.secondary).pluck(:slug).first
  end
end
