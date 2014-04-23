class AddSlugToNewsItems < ActiveRecord::Migration
  def change
    add_column :news_items, :slug, :string
  end
end
