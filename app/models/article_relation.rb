class ArticleRelation < ActiveRecord::Base

  enum kind: { next: 1, previous: 2 }

  belongs_to :article
  belongs_to :related_article, class_name: Article 

  delegate :title, :slug, to: :related_article
end
