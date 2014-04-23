class AddIndexBySlugToNewsItems < ActiveRecord::Migration
  def change
  	add_index :news_items, :slug
  end
end
