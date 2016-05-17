class ArticleDecorator

  def initialize article
    @article = article
  end

  def published_on locale=I18n.locale
    return if @article.published_at.nil?
    I18n.localize @article.published_at.to_date, format: :short
  end

end
