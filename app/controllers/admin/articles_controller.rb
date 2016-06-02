class Admin::ArticlesController < ApplicationController

  rescue_from ActiveRecord::RecordInvalid, with: :render_validation

  def index
    @articles = Article.preload(:tags, :translated_article)
                        .by_publishing
                        .by_creation
  end

  def show
    @article = Article.find params[:id]
    @article.published_at ||= Time.current
    render template: 'articles/show'
  end

  def new
    @article = Article.new
    render action: :edit
  end

  def create
    @article = ArticlePersistence.new Article.new
    @article.attributes = article_params
    @article.save!
    flash[:notice] = success_note(@article)
    redirect_to [:edit, :admin, @article]
  end

  def edit
    @article = Article.find params[:id]
  end

  def update
    article = ArticlePersistence.find(params[:id])
    article.attributes = article_params
    article.save!
    
    flash[:notice] = success_note(article)
    respond_to do |format|
      format.js { render template: 'shared/message' }
      format.html { redirect_to [:edit, :admin, article] }
    end
  end

  def destroy
    @article = Article.find params[:id]
    ArticlePersistence.destroy(@article)
  end

  private

  def success_note article
    I18n.t("admin.articles.saved", 
      title: article.translated_articles.localized(locale).first.title)
  end

  def render_validation record_invalid_exception
    @errors = record_invalid_exception.record.errors
    render template: 'shared/validate'
  end

  def article_params
    params.require(:article)
      .permit(:published_at, :image, tag_ids: [], 
        translated_articles: { 
          en: [:title, :text, :summary], de: [:title, :text, :summary] 
        } )
      .transform_values{ |value| value if value.present? }
  end
end
