class AddAvatarToArticle < ActiveRecord::Migration
  def change
    add_attachment :articles, :avatar
  end
end
