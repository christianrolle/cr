class ArticleDecorator

  def initialize article
    @article = article
  end

  def title locale=I18n.locale
    find_translated_article(locale).title
  end

  def published_on locale=I18n.locale
    return if @article.published_at.nil?
    I18n.localize @article.published_at.to_date, format: :short
  end

  private

  def find_translated_article locale
    @article.translated_articles.detect { |translated_article|
      translated_article.locale == locale || translated_article.title.present?
    }
  end
end
