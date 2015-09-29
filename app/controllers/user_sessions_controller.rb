class UserSessionsController < ApplicationController
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Successfully logged in."
      redirect_to admin_articles_url
    else
      render action: :new
logger.debug 'User session start'+ @user_session.inspect
    end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Successfully logged out."
    redirect_to root_url
  end

#  def new
#    logger.debug '#'*100
#  end
end
