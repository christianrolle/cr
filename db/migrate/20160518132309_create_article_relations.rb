class CreateArticleRelations < ActiveRecord::Migration
  def change
    create_table :article_relations do |t|
      t.integer :kind
      t.belongs_to :article, index: true, foreign_key: true
    end
  end
end
