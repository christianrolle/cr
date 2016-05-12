class ArticleSupplement < ActiveRecord::Base

  has_many :article_tags, dependent: :delete_all, foreign_key: :article_id
  has_many :tags, through: :article_tags

  validate :has_at_least_one_tag, if: :published?

  scope :published, -> { where("published_at < ?", Time.current) }
  scope :unpublished_first, -> { order('published_at IS NULL DESC') }
  scope :by_publishing, -> { order('published_at DESC') }

  def published?
    published_at.present?
  end

  private

  def has_at_least_one_tag
    return true if tags.any?
    errors.add(:tags, :at_least_one)
  end

end
