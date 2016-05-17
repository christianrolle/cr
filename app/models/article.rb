class Article < ActiveRecord::Base

  mount_uploader :image, ArticleImageUploader

  enum locale: [:de, :en]

  # TODO: legacy association start - best before: 15.05.2016
  has_many :article_tags, dependent: :delete_all
  has_many :legacy_tags, through: :article_tags, class_name: Tag
  # legacy association stop
  has_many :article_tag_positions, -> { order('article_tag_positions.position ASC') },
    dependent: :delete_all
  has_many :tags, through: :article_tag_positions
  has_many :translated_articles

  scope :published, -> { where("published_at < ?", Time.current) }
  scope :by_publishing, -> { order('published_at DESC') }
  scope :by_creation, -> { order("#{table_name}.created_at ASC") }
  scope :localized, ->(locale) { 
    joins(:translated_articles)
      .select('articles.*, translated_articles.title, text, summary, translated_articles.slug')
      .merge(TranslatedArticle.localized(locale))
  }
  scope :search_localized, ->(term, locale) {
    localized(locale)
      .merge(TranslatedArticle.search(term))
  }
  scope :tagged, ->(tag_slug) {
    return preload(:tags) if tag_slug.blank?
    eager_load(:tags).merge(Tag.slugged(tag_slug))
  }

  def released?
    published_at.present?
  end

end
