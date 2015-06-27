class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string   :title,                        null: false
      t.string   :slug,                         null: false
      t.datetime :published_at,                 null: false
      t.string   :preview
      t.text     :intro
      t.text     :body
      t.text     :seodata
      t.boolean  :hided,        default: false, null: false

      t.timestamps null: false
    end
    add_index :news, :slug, unique: true
    add_index :news, :published_at
    add_index :news, :hided
  end
end
