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
    assign_translations attributes.delete('translated_articles')
    @article.attributes = attributes.extract!(*@article.class.column_names)
    @association_attributes = attributes
  end

  def save!
    return save_with_translations unless @article.published_at_changed?
    save_with_translations do |article|
      reassociate_siblings(article)
    end
  end

  def destroy
    @article.transaction do
      reassociate_previous_and_next @article
      @article.destroy
    end
  end

  def self.destroy article
    new(article).destroy
  end

  private
  
  def reassociate_previous_and_next article
    reassociate_next article.previous_article, article.next_article
    reassociate_previous article.next_article, article.previous_article
  end

  def save_with_translations &block
    @article.transaction do
      @article.save!
      @article.attributes = @association_attributes
      @article.translated_articles.map { |translated_article|
        translated_article.save! if translated_article.changed?
      }
      block.call(@article) if block_given?
    end
  end

  def assign_translations translations
    return if translations.blank?
    TranslatedArticle.locales.keys.map do |locale|
      next if translations[locale].nil?
      find_or_build_translation(locale).attributes = translations[locale] 
    end
  end

  def reassociate_siblings article
    reassociate_previous_and_next article

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
    attributes.slice('tag_ids', 'published_at', 'slug', 'image').except('id')
  end

  def find_or_build_translation locale
    translated_articles
      .detect { |translation| translation.locale.eql?(locale) } || 
        translated_articles.build(locale: locale)
  end

end
