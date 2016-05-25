class AddIndexToArticleRelations < ActiveRecord::Migration
  def change
    add_index :article_relations, [:article_id, :related_article_id], 
                unique: true
  end
end
