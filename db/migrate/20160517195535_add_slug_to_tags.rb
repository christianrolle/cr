class AddSlugToTags < ActiveRecord::Migration
  def change
    add_column :tags, :slug, :string, index: true

    Tag.all.each do |tag|
      tag.save!
    end
  end
end
