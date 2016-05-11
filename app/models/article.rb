class Article < ActiveRecord::Base
  mount_uploader :image, ArticleImageUploader

  has_many :article_tags, dependent: :delete_all
  has_many :tags, through: :article_tags

  before_validation :set_slug

  validates :published_at, date: { allow_nil: true }
  validates :title_en_or_de, presence: true
  validates :title_en, :title_de, 
    uniqueness: true, length: { in: 3..200 }, allow_blank: true
  validates :slug, uniqueness: true, allow_nil: true
  validates :content_en, presence: true, if: -> { published? && title_en.present? }
  validates :content_de, presence: true, if: -> { published? && title_de.present? }
  validate :has_at_least_one_tag, if: :published?

  scope :published, -> { where("published_at < ?", Time.current) }
  scope :localized, ->(locale) { where.not("title_#{locale}" => nil) }
  scope :unpublished_first, -> { order('published_at IS NULL DESC') }
  scope :by_creation, -> { order('created_at ASC') }
  scope :by_publishing, -> { order('published_at DESC') }
  scope :search, ->(term) {
    term = term.to_s.strip
    return if term.empty?
    where("title_en LIKE :term OR title_de LIKE :term", { term: "%#{term}%" })
  }

  def published_on
    published_at.to_date
  end

  def published?
    published_at.present?
  end

private
  def set_slug
    title = title_en_or_de
    slug = title.parameterize if title.present?
    self.slug = slug
  end

  def has_at_least_one_tag
    return true if tags.any?
    errors.add(:tags, :at_least_one)
  end

  def title_en_or_de
    title_en || title_de
  end
end
