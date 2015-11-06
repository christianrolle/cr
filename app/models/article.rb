class Article < ActiveRecord::Base
  before_validation :generate_slug

  has_many :article_tags, dependent: :delete_all
  has_many :tags, through: :article_tags

  validates :title, uniqueness: true, length: { in: 3..200 }
  validates :slug, uniqueness: true

  scope :published, -> { where.not(published_at: nil) }
  scope :unpublished_first, -> { order('published_at IS NULL DESC') }
  scope :creation_order, -> { order('created_at ASC') }
  scope :ordered, -> { order('published_at DESC') }

  def published_on
    published_at.to_date
  end

  def published?
    published_at.present?
  end
  
  def generate_slug
    self.slug = title.parameterize
  end
end
