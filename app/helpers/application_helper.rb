module ApplicationHelper
  SOCIAL_SHARE_SERVICE_URLS = {
    twitter: 'https://twitter.com/intent/tweet',
    googleplus: 'https://plus.google.com/share',
    facebook: 'https://www.facebook.com/sharer/sharer.php'
  }

  def page_title title
    return 'Christian Rolle' if title.blank?
    title
  end

  def page_description description
    return I18n.t(:meta_description) if description.blank?
    description
  end

  def gravatar_url size=32
    image_path "https://www.gravatar.com/avatar/c1873b0d2c86671bb1b3d44b53b48c09.png?s=#{size}"
  end
  
  def modal title, content
    render layout: 'shared/modal', locals: { title: title } do
      content
    end
  end

  def close_button
    content_tag :button, 'Close', class: 'btn btn-default', 
      'data-dismiss' => 'modal'
  end

  def decorate model, decorator_class=nil
    decorator_class ||= "#{model.class}Decorator".constantize
    decorator = decorator_class.new(model)
    return decorator unless block_given?
    yield(decorator)
  end

  def present model, presenter_class=nil
    presenter_class ||= "#{model.class}Presenter".constantize
    presenter = presenter_class.new(model, self)
    return presenter unless block_given?
    yield(presenter)
  end

  def link_to_share_social service, options={}
    url = SOCIAL_SHARE_SERVICE_URLS[service] + '?' + options.to_param
    link_to I18n.t("social.#{service}"), url, rel: 'external nofollow', 
      class: "share #{service} icon"
  end

  def link_to_alternate
    link_to t("view.locale_#{@locale.secondary}"), 
      alternate_url, locale: @locale.secondary, rel: :alternate
  end

  private

  def alternate_url
    @locale.alternate_url || root_url(locale: @locale.secondary)
  end
end
