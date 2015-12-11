module ApplicationHelper
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
    render layout: 'shared/modal', locals: { title: 'Tags' } do
      content
    end
  end

  def present_collection collection, presenter_class=nil
    return collection if collection.blank?
    presenter_class ||= "#{collection.first.class}Presenter".constantize
    collection.map{ |model| presenter_class.new(model, self) }
  end
end
