class Article < ActiveRecord::Base

  mount_uploader :image, ArticleImageUploader

  enum locale: [:de, :en]

  belongs_to :article_supplement
  # TODO: legacy association start - best before: 15.05.2016
  has_many :article_tags, dependent: :delete_all
  has_many :legacy_tags, through: :article_tags, class_name: Tag
  # legacy association stop
  has_many :article_tag_positions, dependent: :delete_all
  has_many :tags, through: :article_tag_positions


  before_validation :set_slug

  validates :title_en, 
    uniqueness: { scope: :locale }, 
    length: { in: 3..200 }, 
    allow_blank: true
  validates :slug, 
    uniqueness: { scope: :locale }, 
    allow_nil: true
  #validates :text, presence: true, if: -> { published? && title.present? }
  validates :content_en, presence: true, if: -> { published? && title.present? }

  scope :localized, ->(locale) { where(locale: locales[locale.to_sym]) }
  scope :with_tags, -> { includes(article_supplement: :tags) }
  scope :by_creation, -> { order('created_at ASC') }
  scope :by_publishing, -> { 
    includes(:article_supplement)
      .merge(ArticleSupplement.published)
      .merge(ArticleSupplement.by_publishing) 
  }
  scope :search, ->(term) {
    term = term.to_s.strip
    return if term.empty?
    where("title LIKE ?", "%#{term}%")
  }

#  delegate :published?, to: :article_supplement
  def published?
    title.present? && content_en.present?
  end
  private

  def set_slug
    self.slug = title.parameterize if title.present?
  end

  def title
    title_en
  end
end
