class MoveSlugDataToArticles < ActiveRecord::Migration
  def change
    Article.transaction do
      puts "#"*100
      Article.all.each do |article|
        article.slug = article.translated_articles.en.first.slug
        persistence = ArticlePersistence.new article
        persistence.save!
      end
      puts "#"*100
    end
  end
end
