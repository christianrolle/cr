class ArticlePresenter < Presenter
  def tags_with_icon
    tags = model.tags
    return if tags.blank?
    css = 'list-unstyled tags glyphicon glyphicon-tag'
    css << 's' if tags.size > 1
    h.content_tag(:ol, class: css) do
      tags.inject(''.html_safe) { |html, tag|
        html += h.content_tag(:li, tag.name)
      }
    end
  end

  def link_to_avatar
    return h.content_tag(:div, '', class: :avatar) if model.new_record?
    avatar = model.avatar
    image = h.image_tag(avatar.url(:medium)) if avatar.present?
    h.link_to image, h.edit_admin_article_avatar_path(model), remote: true, 
      class: :avatar
  end
 
  def url
    @url ||= h.article_url(model.slug)
  end
end
