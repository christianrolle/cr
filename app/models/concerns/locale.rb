# Service that cares about view localisation
class Locale
  attr_accessor :alternate_url

  delegate :to_s, to: :@locale

  def initialize(locale = nil)
    locale = locale.to_s.to_sym
    @locale = self.class.accept_or_default locale
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

  def self.accept_or_default(locale)
    return locale if available.include?(locale)
    I18n.default_locale
  end
end
