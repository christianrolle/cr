class ArticlePresenter < Presenter

  def tags_with_icon
    return if tags.blank?
    css = 'list-unstyled tags glyphicon glyphicon-tag'
    css << 's' if tags.size > 1
    h.content_tag(:div, class: css) do
      article_tag_positions.inject(''.html_safe) { |html, article_tag_position|
        html += link_to_tagged_articles(article_tag_position.tag)
      }
    end
  end

  def link_to_avatar
    return h.content_tag(:div, '', class: :avatar) if model.new_record?
    avatar = model.image.thumb
    image = h.image_tag(avatar.url) if avatar.present?
    h.link_to image, h.edit_admin_article_avatar_path(model), remote: true, 
      class: :avatar
  end
 
  def url
    @url ||= h.article_url(model.slug, locale: locale)
  end

  def translated_articles_by_locale
    %w(en de).map { |locale| translated_article_by_locale locale }
  end

  def render_related_article kind
    article_relation = find_article_relation(kind.to_s)
    return if article_relation.nil?
    h.render partial: 'article_relations/article_relation', 
              object: article_relation
  end

  private

  def find_article_relation kind
    model.article_relations.detect { |article_relation| 
      article_relation.kind == kind
    }
  end

  def link_to_tagged_articles tag
    h.link_to(tag.name, h.tag_articles_path(tag.slug), rel: :search, 
              hreflang: I18n.locale)
  end

  delegate :tags, to: :model
  delegate :locale, to: I18n

  def translated_article_by_locale locale
    translated_articles.detect { |article| article.locale == locale } ||
      model.translated_articles.build(locale: locale)
  end

end
