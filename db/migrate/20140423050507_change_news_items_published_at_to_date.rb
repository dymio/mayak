class ChangeNewsItemsPublishedAtToDate < ActiveRecord::Migration
  def change
    change_column :news_items, :published_at, :date
  end
end
