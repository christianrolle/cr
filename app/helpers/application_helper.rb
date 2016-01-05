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

  def decorate_collection collection, decorator_class=nil, decorator_type=nil
    return collection if collection.blank?
    decorator_class ||= "#{collection.first.class}#{decorator_type}".constantize
    collection.map{ |model| decorator_class.new(model, locale) }
  end

  def present model, presenter_class=nil
    presenter_class ||= "#{model.class}Presenter".constantize
    presenter = presenter_class.new(model, self)
    return presenter unless block_given?
    yield(presenter)
  end

  def link_to_share_social service, options={}
    url = SOCIAL_SHARE_SERVICE_URLS[service] + '?' + options.to_param
    link_to I18n.t("social.#{service}"), url, rel: :nofollow, 
      class: "share #{service} icon"
  end
end
