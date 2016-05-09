class DocumentsController < ApplicationController

  def show
#    render action: , layout: layout
    render_document layout
  end

  private

  def render_document layout=nil
    render action: params[:document].underscore, layout: layout
  end

  def layout
    return true if params[:layout].nil?
    return false if params[:layout] == 'plain'
    params[:layout]
  end

end
