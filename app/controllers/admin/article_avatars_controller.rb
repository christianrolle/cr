module Admin
  # Controller for articles avatars
  class ArticleAvatarsController < ApplicationController
    def edit
      @article = Article.find params[:article_id]
    end
  end
end
