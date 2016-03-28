class DocumentsController < ApplicationController

  def show
    render action: params[:id]
  end

end
