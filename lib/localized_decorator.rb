class LocalizedDecorator < SimpleDelegator
  attr_reader :locale

  def initialize model, locale=nil
    @locale = locale || I18n.default_locale
    super(model)
  end

  def localize_date date, options={}
    I18n.l(date, options.merge({ locale: locale }))
  end

  def read_localized_attribute name
    read_attribute "#{name}_#{locale}"
  end
end
