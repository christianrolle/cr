class ArticleRelation < ActiveRecord::Base

  enum kind: { next: 1, previous: 2 }

  belongs_to :article

end
