class Admin::ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new article_params
    if @article.save
      redirect_to [:edit, :admin, @article]
    else
      render(action: :new) 
    end
  end

  def edit
    @article = Article.find params[:id]
  end

  def destroy
    @article = Article.find params[:id]
    @article.destroy
  end
private
  def article_params
    logger.debug '#'*100
    params.require(:article).permit(:title, :content)
  end
end
