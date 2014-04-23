class ChangeNewsItemsDateToPublishedAt < ActiveRecord::Migration
  def change
    rename_column :news_items, :date, :published_at
  end
end
