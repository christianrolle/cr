class AddLocalizedSummaryToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :summary_de, :text
    add_column :articles, :summary_en, :text
  end
end
