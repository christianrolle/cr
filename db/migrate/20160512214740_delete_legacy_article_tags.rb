class DeleteLegacyArticleTags < ActiveRecord::Migration
  def change
    Article.transaction do
      Article.all.each do |article|
        article.article_tags.clear
      end
    end
  end
end
