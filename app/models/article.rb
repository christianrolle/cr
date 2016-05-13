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
  has_one :translated_article, ->(locale) { 
    merge(TranslatedArticle.localized locale)
  }

  before_validation :set_slug

  validates :title_en, 
    uniqueness: { scope: :locale }, 
    length: { in: 3..200 }, 
    allow_blank: true
  validates :slug, 
    uniqueness: { scope: :locale }, 
    allow_nil: true
  validates :content_en, presence: true, if: -> { released? && title.present? }

  scope :localized, ->(locale) { eager_load(:translated_article) }
  scope :by_creation, -> { order("#{table_name}.created_at ASC") }
  scope :published, -> { where("published_at < ?", Time.current) }
  scope :by_publishing, -> { published.order('published_at DESC') }

  def released?
    published_at.present?
  end

  private

  def set_slug
    self.slug = title.parameterize if title.present?
  end

  def title
    title_en
  end
end
