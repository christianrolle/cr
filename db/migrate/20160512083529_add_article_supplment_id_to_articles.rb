class AddArticleSupplmentIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :article_supplement_id, :integer
  end
end
