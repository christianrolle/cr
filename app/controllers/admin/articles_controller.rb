class Admin::ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def edit
    @article = Article.find params[:id]
  end

  def new
    @article = Article.new
  end

  def destroy
    @article = Article.find params[:id]
    @article.destroy
  end
end
