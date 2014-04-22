class AddDescriptionKeywordsToNewsItems < ActiveRecord::Migration
  def change
    add_column :news_items, :description, :string
    add_column :news_items, :keywords, :string
  end
end
