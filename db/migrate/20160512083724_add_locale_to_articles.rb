class AddLocaleToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :locale, :integer, default: 0
  end
end
