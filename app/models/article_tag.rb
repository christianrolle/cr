class ArticleTag < ActiveRecord::Base
  belongs_to :tag, counter_cache: true
  belongs_to :article

#  validates :article, :tag, presence: true

  delegate :name, to: :tag
end
