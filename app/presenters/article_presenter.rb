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

  def localized_title
    title = title_de_or_en
    return model.title_en if title.blank?
    title
  end

  def localized_content
    content = content_de_or_en
    return model.content_en if content.blank?
    content
  end

  def localized_publishing_date
    return unless model.published?
    I18n.l(model.published_at.to_date)
  end
private
  def content_de_or_en
    model.read_attribute "content_#{I18n.locale}"
  end

  def title_de_or_en
    model.read_attribute "title_#{I18n.locale}"
  end
end
