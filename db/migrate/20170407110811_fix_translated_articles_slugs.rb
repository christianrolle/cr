class FixTranslatedArticlesSlugs < ActiveRecord::Migration
  def change
    translated_articles.each do |article|
      article.slug = article.title.parameterize
      article.save!
    end
  end

  def translated_articles
    TranslatedArticle.by_publishing
  end
end
