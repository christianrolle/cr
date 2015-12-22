class ArticlePresenter < Presenter
  SOCIAL_SHARE_URLS = { 
    twitter: 'http://twitter.com/home?status',
    google_plus: 'https://plus.google.com/share?url'
  }

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

  def social_share_url social_service
    "#{SOCIAL_SHARE_URLS[social_service]}=#{article_url}"
  end
private
  def article_url
    @article_url ||= h.article_url(model)
  end
end
