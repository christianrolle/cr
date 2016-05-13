class TranslatedArticle < ActiveRecord::Base

  mount_uploader :image, ArticleImageUploader

  enum locale: { en: 1, de: 2 }

  belongs_to :article
  has_many :article_tag_positions, through: :article
  has_many :tags, through: :article_tag_positions

  before_validation :set_slug

  validates :title, 
    uniqueness: { scope: :locale }, 
    length: { in: 3..200 }, 
    allow_blank: true
  validates :slug, 
    uniqueness: { scope: :locale }, 
    allow_nil: true
  validates :text, presence: true, if: -> { released? && title.present? }

  scope :localized, ->(locale) { where(locale: locales[locale.to_s]) }
  scope :search, ->(term) {
    term = term.to_s.strip
    return if term.empty?
    where("title LIKE ?", "%#{term}%")
  }
  scope :by_publishing, -> { eager_load(:article).merge(Article.by_publishing) }

  delegate :released?, :published_at, to: :article

  private

  def set_slug
    self.slug ||= title.parameterize if title.present?
  end

end
