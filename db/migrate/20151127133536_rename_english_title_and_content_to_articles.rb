class RenameEnglishTitleAndContentToArticles < ActiveRecord::Migration
  def change
    rename_column :articles, :title, :title_en
    rename_column :articles, :content, :content_en
  end
end
