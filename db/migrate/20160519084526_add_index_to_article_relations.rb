class AddIndexToArticleRelations < ActiveRecord::Migration
  def change
    add_index :article_relations, [:article_id, :related_article_id], 
                unique: true
    # Associates previous and next articles to each other
    Article.all.each do |article|
      ArticlePersistence.new(article).save!
    end
  end
end
