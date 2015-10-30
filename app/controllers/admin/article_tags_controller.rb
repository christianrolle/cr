class Admin::ArticleTagsController < ApplicationController
  def create
    @article_tag = ArticleTag.new article_id: params[:article_id], 
                                  tag_id: params[:id]
    @article_tag.save
  end

  def destroy
    @article_tag = ArticleTag.find params[:id]
    @article_tag.destroy
  end
end
