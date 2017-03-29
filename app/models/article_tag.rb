# Model for associating articles with their tags
class ArticleTag < ActiveRecord::Base
  belongs_to :tag, counter_cache: true
  belongs_to :article

  delegate :name, to: :tag
end
