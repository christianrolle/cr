class DocumentsController < ApplicationController

  def show
    render action: params[:document]
  end

end
