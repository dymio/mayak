class CreateNewsItems < ActiveRecord::Migration
  def change
    create_table :news_items do |t|
      t.string  :title
      t.string  :slug,         null: false
      t.date    :published_at, null: false
      t.text    :lead
      t.text    :body
      t.string  :description
      t.string  :keywords
      t.boolean :hided,        null: false, default: false

      t.timestamps
    end

    add_index :news_items, :published_at
    add_index :news_items, :slug, unique: true
  end
end
