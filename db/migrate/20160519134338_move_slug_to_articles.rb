class MoveSlugToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :slug, :string, index: true

    Article.all.each do |article|
      article.slug = article.translated_articles.en.first.slug
      article.save!
    end
  end
end
