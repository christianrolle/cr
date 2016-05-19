class TranslatedArticle < ActiveRecord::Base

  enum locale: { en: 1, de: 2 }
  
  LOCALIZABLE_ATTRIBUTES = %w(title text summary slug)

  belongs_to :article
  has_many :article_tag_positions, through: :article
  has_many :tags, through: :article_tag_positions
  has_many :translated_articles, ->(translated_article) { 
      where("#{table_name}.id != ?", translated_article.id) 
    },
    through: :article 

  before_validation :set_slug

  validates :title, 
    uniqueness: { scope: :locale }, 
    length: { in: 3..200 }, 
    allow_blank: true
  validates :slug, 
    uniqueness: { scope: :locale }, 
    allow_nil: true
  validates :text, presence: true, if: -> { released? && title.present? }

  scope :localized, ->(locale) { 
    where(table_name => { locale: locales[locale.to_s] })
  }
  scope :by_publishing, -> { 
    eager_load(:article).merge(Article.published).merge(Article.by_publishing) 
  }
  scope :search, ->(term) {
    term = term.to_s.strip
    return if term.empty?
    where("title LIKE ?", "%#{term}%")
  }
  scope :select_localizeables, -> { 
    attributes = LOCALIZABLE_ATTRIBUTES.map { |name| "#{table_name}.#{name}" }
    select(attributes.join(', '))
  }

  delegate :released?, :published_at, :image, to: :article

  private

  def set_slug
    self.slug ||= title.parameterize if title.present?
  end

end
