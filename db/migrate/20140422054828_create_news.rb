class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string  :title
      t.string  :slug,         null: false
      t.date    :published_at, null: false
      t.text    :lead
      t.text    :body
      t.text    :seodata
      t.boolean :hided,        null: false, default: false

      t.timestamps
    end

    add_index :news, :published_at
    add_index :news, :slug, unique: true
  end
end
