class Admin::ArticleAvatarsController < ApplicationController
  def edit
    @article = Article.find params[:article_id]
  end
end
