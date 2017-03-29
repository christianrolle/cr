# Decorates articles with extra logic
class ArticleDecorator
  def initialize(article)
    @article = article
  end

  def published_on
    return if @article.published_at.nil?
    I18n.localize @article.published_at.to_date, format: :short
  end

  def related_article(kind)
    related_articles(kind).first
  end

  def related_articles(kind)
    select_related_articles_by_kind(kind).map(&:related_article)
  end

  private

  def select_related_articles_by_kind(kind)
    kind_enum = ArticleRelation.kinds[kind.to_s]
    article_relations.select { |relation| relation.kind == kind_enum }
  end

  def article_relations
    @article_relations ||= @article.article_relations.preload(:related_article)
  end
end
