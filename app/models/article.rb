class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  validates :title, presence: true, length: { in: 3..200 }

  def published_on
    published_at.to_date
  end
end
