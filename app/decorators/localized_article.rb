class LocalizedArticle < LocalizedDecorator
  def self.find_by_slug slug
    new Article.find_by_slug(slug)
  end

  def title
    localized_attribute :title
  end

  def content
    localized_attribute :content
  end
=begin
  def slug
    localized_attribute :slug
  end
=end
  def publishing_date
    return unless published?
    localize_date published_at.to_date
  end

private
  def localized_attribute name
    value = read_localized_attribute name
    return value if value.present?
    read_attribute "#{name}_en"
  end
end
