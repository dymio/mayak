class ChangeNewsItemsMakeSlugIndexUnique < ActiveRecord::Migration
  def change
    remove_index :news_items, :slug
    add_index :news_items, :slug, unique: true
  end
end
