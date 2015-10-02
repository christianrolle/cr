class Article < ActiveRecord::Base
  before_validation :generate_slug
  validates :title, uniqueness: true, length: { in: 3..200 }
  validates :slug, uniqueness: true

  scope :published, -> { where.not(published_at: nil) }

  def published_on
    published_at.to_date
  end

  def generate_slug
    self.slug = title.parameterize
  end
end
