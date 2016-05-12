class Article < ActiveRecord::Base

  mount_uploader :image, ArticleImageUploader

  enum locale: [:de, :en]

  belongs_to :article_supplement

  before_validation :set_slug

  validates :title_en, presence: true
  validates :title_en, 
    uniqueness: { scope: :locale }, 
    length: { in: 3..200 }, 
    allow_blank: true
  validates :slug, uniqueness: true, allow_nil: true
  validates :content_en, presence: true, if: -> { published? && title_en.present? }

  scope :localized, ->(locale) { where.not("title_#{locale}" => nil) }
  scope :by_creation, -> { order('created_at ASC') }
  scope :search, ->(term) {
    term = term.to_s.strip
    return if term.empty?
    where("title_en LIKE :term OR title_de LIKE :term", { term: "%#{term}%" })
  }
  scope :locale, ->(locale) { select("title_#{locale}, content_#{}") }

  delegate :published?, to: :article_supplement
  private

  def set_slug
    title = title_en
    slug = title.parameterize if title.present?
    self.slug = slug
  end

end
