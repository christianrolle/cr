class Article < ActiveRecord::Base
  has_many :article_tags, dependent: :delete_all
  has_many :tags, through: :article_tags

  before_validation :set_slug 

  validates :published_at, date: { allow_blank: true }
  validates :title, presence: true, allow_blank: false
  validates :title_en, :title_de, 
    uniqueness: true, length: { in: 3..200 }, allow_blank: true
  validates :slug, uniqueness: true
  validates :content_en, presence: true, if: -> { published? && title_en.present? }
  validates :content_de, presence: true, if: -> { published? && title_de.present? }
  validate :has_at_least_one_tag, if: :published?

  scope :published, -> { where.not(published_at: nil) }
  scope :localized, ->(locale) { where.not("title_#{locale}" => nil) }
  scope :unpublished_first, -> { order('published_at IS NULL DESC') }
  scope :by_creation, -> { order('created_at ASC') }
  scope :by_publishing, -> { order('published_at DESC') }

  def title
    title_en || title_de
  end

  def published_on
    published_at.to_date
  end

  def published?
    published_at.present?
  end
  
  def set_slug
    self.slug = title.parameterize if title.present?
  end

  private
  def has_at_least_one_tag
    return if tags.any?
    message = I18n.t('errors.format', 
        attribute: self.class.human_attribute_name(:tags), 
        message: I18n.t('errors.messages.at_least_one'))
    errors.add(:base, message)
  end
end
