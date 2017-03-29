class RemoveObsoleteAttributesFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :title_de
    remove_column :articles, :content_de
    remove_column :articles, :summary_de
    remove_column :articles, :title_en
    remove_column :articles, :content_en
    remove_column :articles, :summary_en
    remove_column :articles, :slug
    remove_column :articles, :image
  end
end
