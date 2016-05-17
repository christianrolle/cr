class ArticleTagPosition < ActiveRecord::Base

  belongs_to :article
  belongs_to :tag

  delegate :name, to: :tag

end
