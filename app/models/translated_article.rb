# frozen_string_literal: true

# Model for tranlsated articles. That are the translationable elements of an article.
class TranslatedArticle < ActiveRecord::Base
  enum locale: { en: 1, de: 2 }

  belongs_to :article
  has_many :article_relations, through: :article
  has_many :article_tag_positions, through: :article
  has_many :tags, through: :article_tag_positions

  validates :title, uniqueness: { scope: :locale },
                    length: { in: 3..200 },
                    allow_blank: true
  validates :text, presence: true,
                   if: -> { released? && title.present? }

  scope :localized, ->(locale) {
    where(table_name => { locale: locales[locale.to_s] })
  }
  scope :by_publishing, -> do
    eager_load(:article)
      .merge(Article.published)
      .merge(Article.by_publishing)
  end
  scope :search, ->(term) {
    term = term.to_s.strip
    return if term.empty?
    where('title LIKE ?', "%#{term}%")
  }
  scope :tagged, ->(tag_slug) do
    return if tag_slug.blank?
    joins(:tags).merge(Tag.slugged(tag_slug))
  end

  def to_param
    "#{id}-#{slug}"
  end

  delegate :released?, :published_at, :image, to: :article
end
