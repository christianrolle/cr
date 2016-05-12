class RemoveDeAttributesFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :title_de
    remove_column :articles, :content_de
    remove_column :articles, :summary_de
  end
end
