class Admin::TagsController < ApplicationController
  def index
    respond_to do |format|
      format.json do 
        article = Article.find params[:article_id]
        @tags = Tag.search(params[:search])
                    .excluding(article.tag_ids)
                    .ordered.all
        render json: @tags.as_json(only: [:id, :name])
      end
      format.js { @tags = Tag.ordered.all }
    end
  end

  def edit
    @tag = Tag.find params[:id]
  end

  def create
    @tag = Tag.new tag_params
    @tag.save!
  end

  def update
    @tag = Tag.find params[:id]
    @tag.attributes = tag_params
    @tag.save!
  end

  def destroy
    @tag = Tag.find params[:id]
    @tag.destroy
  end

private
  def tag_params
    params.require(:tag).permit(:name)
  end
end
