class Article < ActiveRecord::Base

  mount_uploader :image, ArticleImageUploader

  enum locale: [:de, :en]

  belongs_to :article_supplement
  has_many :tags, through: :article_supplement

  before_validation :set_slug

  validates :title, 
    uniqueness: { scope: :locale }, 
    length: { in: 3..200 }, 
    allow_blank: true
  validates :slug, uniqueness: true, allow_nil: true
  validates :text, presence: true, if: -> { published? && title.present? }

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

  delegate :published?, to: :article_supplement

  private

  def set_slug
    self.slug = title.parameterize if title.present?
  end

end
