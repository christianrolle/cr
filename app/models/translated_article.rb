class TranslatedArticle < ActiveRecord::Base

  mount_uploader :image, ArticleImageUploader

  enum locale: [:de, :en]

  belongs_to :article

  before_validation :set_slug, unless: :published?

  validates :title, 
    uniqueness: { scope: :locale }, 
    length: { in: 3..200 }, 
    allow_blank: true
  validates :slug, 
    uniqueness: { scope: :locale }, 
    allow_nil: true
  validates :text, presence: true, if: -> { published? && title.present? }

  delegate :published?, to: :article

  private

  def set_slug
    self.slug ||= title.parameterize if title.present?
  end

end
