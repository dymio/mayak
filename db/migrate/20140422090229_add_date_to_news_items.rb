class AddDateToNewsItems < ActiveRecord::Migration
  def change
    add_column :news_items, :date, :datetime
  end
end
