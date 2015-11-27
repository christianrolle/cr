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

  def localized_or_default_title
    title || model.title_en
  end

  def localized_publishing_date
    return unless model.published?
    I18n.l(model.published_at.to_date)
  end

  def content
    model.read_attribute "content_#{I18n.locale}"
  end

  def title
    model.read_attribute "title_#{I18n.locale}"
  end
end
