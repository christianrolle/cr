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

  scope :localized, ->(locale) { 
    eager_load(:translated_articles)
      .merge(TranslatedArticle.localized(locale))
  }
  scope :by_creation, -> { order("#{table_name}.created_at ASC") }
  scope :published, -> { where("published_at < ?", Time.current) }
  scope :by_publishing, -> { published.order('published_at DESC') }

  def released?
    published_at.present?
  end

end
