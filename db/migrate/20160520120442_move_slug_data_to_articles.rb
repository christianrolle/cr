class MoveSlugDataToArticles < ActiveRecord::Migration
  def change
    Article.transaction do
      Article.all.each do |article|
        article.slug = article.translated_articles.en.first.slug
        article.published_at += 1.second if article.published_at.present?
        persistence = ArticlePersistence.new article
        persistence.save!
      end
    end
  end
end
