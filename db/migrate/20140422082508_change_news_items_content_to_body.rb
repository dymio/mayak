class ChangeNewsItemsContentToBody < ActiveRecord::Migration
  def up
  	rename_column :news_items, :content, :body
  end

  def down
  	rename_column :news_items, :body, :content
  end
end
