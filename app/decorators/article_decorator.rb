class ArticleDecorator

  def initialize article
    @article = article
  end

  def published_on locale=I18n.locale
    return if @article.published_at.nil?
    I18n.localize @article.published_at.to_date, format: :short
  end

  def related_article kind
    related_articles(kind).first
  end

  def related_articles kind
    article_relations.select { |article_relation| 
      article_relation.kind == ArticleRelation.kinds[kind.to_s] 
    }.map { |article_relation| article_relation.related_article }
  end

  private

  def article_relations
    @article_relations ||= @article.article_relations.preload(:related_article)
  end

end
