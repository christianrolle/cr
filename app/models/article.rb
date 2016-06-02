class Article < ActiveRecord::Base

  mount_uploader :image, ArticleImageUploader

  has_many :article_tag_positions, 
    -> { order('article_tag_positions.position ASC') },
    dependent: :delete_all
  has_many :tags, through: :article_tag_positions
  has_many :translated_articles, dependent: :delete_all
  has_one :translated_article, -> {
    merge(TranslatedArticle.localized(I18n.locale)) 
  }
  has_many :article_relations, dependent: :delete_all
  has_many :related_articles, 
    -> { select("articles.*, article_relations.kind") },
    through: :article_relations

  has_one :article_relation
  has_one :previous_article_relation, -> { previous },
          class_name: ArticleRelation
  has_one :previous_article, through: :previous_article_relation,
          source: :related_article
  has_one :next_article_relation, -> { merge(ArticleRelation.next) },
          class_name: ArticleRelation
  has_one :next_article, through: :next_article_relation, 
          source: :related_article

  validates :slug, uniqueness: true, allow_nil: true
  validates :slug, presence: true, if: :released?

  scope :published, -> { where("published_at < ?", Time.current) }
  scope :published_before, ->(time) { published.where("published_at < ?", time) }
  scope :published_after, ->(time) { published.where("published_at > ?", time) }
  scope :by_publishing, ->(order=:desc) { order(published_at: order) }
  scope :by_creation, -> { order("#{table_name}.created_at ASC") }
  scope :search, ->(term) {
    return if term.blank?
    joins(:translated_article)
      .merge(TranslatedArticle.search(term))
  }
  scope :tagged, ->(tag_slug) { 
    joins(:tags).merge(Tag.slugged(tag_slug)) if tag_slug.present?
  }

  delegate :title, :text, :summary, to: :translated_article

  def released?
    published_at.present?
  end

end
