class CreateGermanArticles < ActiveRecord::Migration
  def change
    Article.transaction do
      Article.all.each do |legacy_article|

        legacy_article.article_tags.each_with_index do |article_tag, index|
          position = index + 1
          legacy_article.article_tag_positions.create!({ 
            tag: article_tag.tag, 
            position: position 
          })
        end

        article_attributes = {
          article: legacy_article,
          image: legacy_article.image,
          created_at: legacy_article.created_at,
          updated_at: legacy_article.updated_at
        }
        english_article = TranslatedArticle.new article_attributes
        english_article.locale = :en
        english_article.title = legacy_article.title_en
        english_article.text = legacy_article.content_en
        english_article.summary = legacy_article.summary_en
        english_article.slug = legacy_article.slug

        german_article = TranslatedArticle.new article_attributes
        german_article.locale = :de
        german_article.title = legacy_article.title_de
        german_article.text = legacy_article.content_de
        german_article.summary = legacy_article.summary_de
        
        english_article.save!
        german_article.save!

      end
    end
  end
end
