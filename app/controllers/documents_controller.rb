# Controller for all kind og documents like resume
class DocumentsController < ApplicationController
  helper Layout::InlineHelper

  def show
    render_document layout
  end

  private

  def render_document(layout = nil)
    render action: params[:document].underscore, layout: layout
  end

  def layout
    return true if params[:layout].nil?
    params[:layout]
  end
end
