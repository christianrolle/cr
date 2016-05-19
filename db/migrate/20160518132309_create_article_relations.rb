class CreateArticleRelations < ActiveRecord::Migration
  def change
    create_table :article_relations do |t|
      t.integer :kind
      t.belongs_to :article, foreign_key: true
      t.integer :related_article_id
    end
  end
end
