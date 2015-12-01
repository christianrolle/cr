class Admin::ArticlesController < ApplicationController
  def index
    @articles = Article.includes(:tags)
                  .unpublished_first.by_publishing.by_creation            
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new article_params
    return render_validation unless @article.save
  end

  def edit
    @article = Article.find params[:id]
  end

  def update
    @article = Article.find params[:id]
    @article.attributes = article_params
    return render_validation unless @article.save
    render nothing: true
  end

  def destroy
    @article = Article.find params[:id]
    @article.destroy
  end
private
  def render_validation
    render template: 'shared/validate'
  end

  def article_params
    params.require(:article)
      .permit(:title_de, :title_en, :content_de, :content_en, :published_at,
        tag_ids: [])
  end
end
