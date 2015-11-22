module ApplicationHelper
  def gravatar_url size=32
    image_path "http://www.gravatar.com/avatar/c1873b0d2c86671bb1b3d44b53b48c09.png?s=#{size}"
  end
  
  def modal title, content
    render layout: 'shared/modal', locals: { title: 'Tags' } do
      content
    end
  end
end
