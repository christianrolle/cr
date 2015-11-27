class AddGermanTitleAndContentToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :title_de, :string
    add_column :articles, :content_de, :text
  end
end
