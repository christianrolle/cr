class ArticlePersistence

  attr_reader :article

  delegate :translated_articles, to: :article

  def initialize article
    @article = article
  end

  def self.find id
    new Article.find(id)
  end

  def attributes= new_attributes
    attributes = new_attributes.stringify_keys
    @article.attributes = extract_article_attributes(attributes)
    translation_attributes = attributes['translated_articles']
    return if translation_attributes.nil?
    translated_articles = find_or_build_translations(translation_attributes)
  end

  def save!
    @article.transaction do
      @article.save!
      @article.translated_articles.map { |translated_article|
        translated_article.save! if translated_article.changed?
      }
      reassociate_siblings @article
    end
  end

  private

  def reassociate_siblings article
    reassociate_next article.previous_article, article.next_article
    reassociate_previous article.next_article, article.previous_article

    previous_article = Article.published_before(article.published_at)
                              .by_publishing
                              .first
    next_article = Article.published_after(article.published_at)
                          .by_publishing(:asc)
                          .first

    reassociate_next previous_article, article
    reassociate_previous next_article, article

    reassociate_next article, next_article
    reassociate_previous article, previous_article
  end

  def reassociate_next article, next_article
    return if article.nil?
    article.next_article = next_article
  end

  def reassociate_previous article, previous_article
    return if article.nil?
    article.previous_article = previous_article
  end

  def find_or_build_translations attributes
    TranslatedArticle.locales.keys.map do |locale|
      translated_article = find_or_build_translated_article(locale)
      translated_article.attributes = attributes[locale]
      translated_article
    end
  end

  def extract_article_attributes attributes
    attributes.slice(*@article.class.column_names).except('id')
  end

  def find_or_build_translated_article locale
    translated_article = translated_articles.localized(locale).first
    return translated_article if translated_article.present?
    translated_articles.build(locale: locale)
  end
end
