class MoveSlugToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :slug, :string, index: true
  end
end
