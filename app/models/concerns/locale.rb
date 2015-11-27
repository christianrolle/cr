class Locale
  def initialize locale
    @locale = self.class.accept_or_default locale.to_sym
  end

  def current
    @locale
  end

  def secondary
    Locale.available.detect { |locale| locale != current } 
  end

  def self.available
    I18n.available_locales
  end
private
  def self.accept_or_default locale
    return locale if available.include?(locale)
    I18n.default_locale
  end
end
