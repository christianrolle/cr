class Article < ActiveRecord::Base

  mount_uploader :image, ArticleImageUploader

  enum locale: [:de, :en]

  # TODO: legacy association start - best before: 15.05.2016
  has_many :article_tags, dependent: :delete_all
  has_many :legacy_tags, through: :article_tags, class_name: Tag
  # legacy association stop
  has_many :article_tag_positions, 
    -> { order('article_tag_positions.position ASC') },
    dependent: :delete_all
  has_many :tags, through: :article_tag_positions
  has_many :translated_articles
  has_one :translated_article, -> {
    merge(TranslatedArticle.localized(I18n.locale)) 
  }
  has_many :article_relations, dependent: :delete_all
  has_many :related_articles, through: :article_relations
  has_one :article_relation
  has_one :previous_article_relation, -> { previous },
          class_name: ArticleRelation
  has_one :previous_article, through: :previous_article_relation,
          source: :related_article
  has_one :next_article_relation, -> { merge(ArticleRelation.next) },
          class_name: ArticleRelation
  has_one :next_article, through: :next_article_relation, 
          source: :related_article

  scope :published, -> { where("published_at < ?", Time.current) }
  scope :published_before, ->(time) { published.where("published_at < ?", time) }
  scope :published_after, ->(time) { published.where("published_at > ?", time) }
  scope :by_publishing, ->(order=:desc) { order(published_at: order) }
  scope :by_creation, -> { order("#{table_name}.created_at ASC") }
  scope :localized, ->(locale) { 
    joins(:translated_articles)
      .select("#{table_name}.*")
      .merge(TranslatedArticle.select_localizeables)
      .merge(TranslatedArticle.localized(locale))
  }
  scope :search_localized, ->(term, locale) {
    localized(locale)
      .merge(TranslatedArticle.search(term))
  }
  scope :tagged, ->(tag_slug) { 
    joins(:tags).merge(Tag.slugged(tag_slug)) if tag_slug.present?
  }

  delegate :title, :text, :summary, :slug, to: :translated_article

  def released?
    published_at.present?
  end

end
