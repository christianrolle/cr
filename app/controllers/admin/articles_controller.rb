class Admin::ArticlesController < ApplicationController

  rescue_from ActiveRecord::RecordInvalid, with: :render_validation

  def index
    @articles = Article.localized(locale)
                        .preload(:tags)
                        .by_publishing
                        .by_creation
  end

  def show
    @article = Article.find params[:id]
    @article.published_at ||= Time.current
#    @localized_article = LocalizedArticle.new article, locale
    render template: 'articles/show'
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new article_params
    @article.save!
    flash[:notice] = success_note(@article)
    redirect_to [:edit, :admin, @article]
  end

  def edit
    @article = Article.find params[:id]
  end

  def update
    article = Article.find params[:id]
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
    @article.destroy
  end
private
  def success_note article
    I18n.t("admin.articles.saved", title: LocalizedArticle.new(article).title)
  end

  def render_validation record_invalid_exception
    @errors = record_invalid_exception.record.errors
    render template: 'shared/validate'
  end

  def article_params
    params.require(:article)
      .permit(:title_de, :title_en, :content_de, :content_en, :summary_de, 
        :summary_en, :published_at, :image, tag_ids: [])
      .transform_values{ |value| value if value.present? }
  end
end
