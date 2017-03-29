# Controller for messaging
class MessagesController < ApplicationController
  protect_from_forgery with: :null_session, only: proc { |c| c.request.format.json? }

  def create
    @message = message_params[:text]
    render json: "Thank you for talking to me: '#{@message}'"
  end

  private

  def message_params
    params.require(:message).permit(:text)
  end
end
