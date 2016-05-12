class RenameEnAttributesForArticles < ActiveRecord::Migration
  def change
    rename_column :articles, :title_en, :title
    rename_column :articles, :content_en, :text
    rename_column :articles, :summary_en, :summary
  end
end
