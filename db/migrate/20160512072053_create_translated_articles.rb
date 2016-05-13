class CreateTranslatedArticles < ActiveRecord::Migration
  def change
    create_table :translated_articles do |t|
      t.integer :locale, index: true, default: 0
      t.string :title
      t.text :text
      t.text :summary
      t.string :slug, index: true
      t.string :image
      t.references :article, index: true, foreign_key: true

      t.timestamps
    end
  end
end
