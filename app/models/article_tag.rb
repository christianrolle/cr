class ArticleTag < ActiveRecord::Base
  belongs_to :tag

  delegate :name, to: :tag
end
