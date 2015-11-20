class ArticlePresenter < Presenter
  def tags_with_icon
    css = 'list-unstyled tags glyphicon glyphicon-tag'
    css << 's' if model.tags.size > 1
    h.content_tag(:ol, class: css) do
      model.tags.inject(''.html_safe) { |html, tag|
        html += h.content_tag(:li, tag.name)
      }
    end
  end
end
