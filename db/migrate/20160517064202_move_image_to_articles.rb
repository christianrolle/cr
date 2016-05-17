class MoveImageToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :image, :string

    Article.all.each do |article|
      article.image = article.translated_articles.first.image
      article.save
    end
  end
end
