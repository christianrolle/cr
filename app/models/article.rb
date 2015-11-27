class Article < ActiveRecord::Base
  before_validation :generate_slug

  has_many :article_tags, dependent: :delete_all
  has_many :tags, through: :article_tags

  validates :title, uniqueness: true, length: { in: 3..200 }
  validates :slug, uniqueness: true
  validate :has_at_least_one_tag, if: :published, if: :published?

  scope :published, -> { where.not(published_at: nil) }
  scope :localized, ->(locale) { where.not("title_#{locale}" => nil) }
  scope :unpublished_first, -> { order('published_at IS NULL DESC') }
  scope :by_creation, -> { order('created_at ASC') }
  scope :by_publishing, -> { order('published_at DESC') }

  def published_on
    published_at.to_date
  end

  def published?
    published_at.present?
  end
  
  def generate_slug
    self.slug = title.parameterize
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
