class Article < ActiveRecord::Base
  before_validation :generate_slug

  has_many :article_tags, dependent: :delete_all
  has_many :tags, through: :article_tags

  validates :title, uniqueness: true, length: { in: 3..200 }
  validates :slug, uniqueness: true

  scope :published, -> { where.not(published_at: nil) }

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
