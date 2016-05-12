class CreateArticleSupplements < ActiveRecord::Migration
  def change
    create_table :article_supplements do |t|
      t.datetime :published_at
    end
  end
end
