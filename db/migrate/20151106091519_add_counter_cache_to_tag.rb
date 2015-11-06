class AddCounterCacheToTag < ActiveRecord::Migration
  def change
    add_column :tags, :article_tags_count, :integer, default: 0
  end
end
