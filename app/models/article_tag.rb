class ArticleTag < ActiveRecord::Base
  belongs_to :tag

  validates :article, :tag, presence: true

  delegate :name, to: :tag
end
