class AssociateRelatedArticles < ActiveRecord::Migration
  def change
    Article.transaction do
      Article.all.each do |article|
        next if article.published_at.nil?
        article.published_at += 1.second
        persistence = ArticlePersistence.new article
        persistence.save!
      end
    end
  end
end
