class CreateNewsItems < ActiveRecord::Migration
  def change
    create_table :news_items do |t|
      t.string :title
      t.text :lead
      t.text :content

      t.timestamps
    end
  end
end
