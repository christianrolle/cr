# Controller base class, concerning about global controller tasks
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  before_filter :set_locale, :strict_transport_security

  private

  def strict_transport_security
    response.headers['Strict-Transport-Security'] = 'max-age=0; includeSubDomains'
  end
=begin
  def set_locale
    session[:locale] = params[:locale] if params[:locale]
    session[:locale] ||= extract_locale_from_header
    @locale = Locale.new session[:locale]
    I18n.locale = @locale.current
  end
=end
  def set_locale
    @locale = Locale.new requested_locale
    session[:locale] = @locale.to_s
    I18n.locale = @locale.current
  end

  def switch_locale_and_redirect_to_referer
    session[:locale] = params[:locale]
    redirect_to request.referer
  end

  def requested_locale
    params[:locale] || session[:locale] || extract_locale_from_header
  end

  def extract_locale_from_header
    locale = request.env['HTTP_ACCEPT_LANGUAGE'] || I18n.default_locale.to_s
    locale.scan(/^[a-z]{2}/).first
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def alternate_to(url)
    @locale.alternate_url = url
  end
end
