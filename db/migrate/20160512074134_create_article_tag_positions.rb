class CreateArticleTagPositions < ActiveRecord::Migration
  def change
    create_table :article_tag_positions do |t|
      t.references :article, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true
      t.integer :position
    end
  end
end
