class AddHidedToNewsItems < ActiveRecord::Migration
  def change
    add_column :news_items, :hided, :boolean
  end
end
