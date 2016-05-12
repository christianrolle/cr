class CreateGermanArticles < ActiveRecord::Migration
  def change
    Article.transaction do
      Article.all.each do |article|
        german_article = article.dup
        german_article.locale = :de
        article.locale = :en

        german_article.slug = nil

        article.title_de = nil
        article.content_de = nil
        article.summary_de = nil
        german_article.title_en = german_article.title_de
        german_article.content_en = german_article.content_de
        german_article.summary_en = german_article.summary_de
        german_article.title_de = nil
        german_article.content_de = nil
        german_article.summary_de = nil

        attribtues = { published_at: article.published_at }
        article_supplement = ArticleSupplement.create! attributes

        article.article_supplement = article_supplement
        german_article.article_supplement = article_supplement

        article.save!
        german_article.save!
      end
    end
  end
end
