class ArticlePersistence

  attr_reader :article

  delegate :translated_articles, :to_model, to: :article

  def initialize article
    @article = article
  end

  def self.find id
    new Article.find(id)
  end

  def attributes= new_attributes
    attributes = new_attributes.stringify_keys
    @article.attributes = extract_article_attributes(attributes)
    @article.translated_articles = find_or_build_translated_articles(attributes['translated_articles'])
  end

  def save!
    @article.transaction do
      @article.save!
      @article.translated_articles.map { |translated_article|
        translated_article.save! if translated_article.changed?
      }
    end
  end

  private

  def find_or_build_translated_articles attributes
    %w(en de).map do |locale|
      translated_article = find_or_build_translated_article(locale)
      translated_article.attributes = attributes[locale]
      translated_article
    end
  end

  def extract_article_attributes attributes
    attributes.slice(@article.class.column_names).except(:id)
  end

  def find_or_build_translated_article locale
    translated_article = @article.translated_articles.localized(locale).first
    return translated_article if translated_article.present?
    @article.translated_articles.build(locale: locale)
  end
end
