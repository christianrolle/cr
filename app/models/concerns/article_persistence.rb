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
    assign_translations attributes['translated_articles']
  end

  def save!
    return save_with_translations unless @article.published_at_changed?
    save_with_translations do |article|
      reassociate_siblings(article)
    end
  end

  private

  def save_with_translations &block
    @article.transaction do
      @article.save!
      @article.translated_articles.map { |translated_article|
        translated_article.save! if translated_article.changed?
      }
      block.call(@article) if block_given?
    end
  end

  def assign_translations translations
    TranslatedArticle.locales.keys.map do |locale|
      next if translations[locale].nil?
      find_or_build_translation(locale).attributes = translations[locale] 
    end
  end

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

  def extract_article_attributes attributes
    attributes.slice(*@article.class.column_names).except('id')
  end

  def find_or_build_translation locale
    translated_articles
      .detect { |translation| translation.locale.eql?(locale) } || 
        translated_articles.build(locale: locale)
  end

end
