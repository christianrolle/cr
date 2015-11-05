class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #filter_parameter_logging :password

  helper_method :current_user

  before_filter :set_locale
  
  ACCEPTED_LOCALES = %w(de en)

private
  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

  def accepted_locale
    extracted_locale = extract_locale_from_accept_language_header
    return extracted_locale if ACCEPTED_LOCALES.include?(extracted_locale)
    I18n.default_locale
  end

  def set_locale
    I18n.locale = accepted_locale
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
end
