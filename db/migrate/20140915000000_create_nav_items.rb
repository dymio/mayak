class CreateNavItems < ActiveRecord::Migration
  def change
    create_table :nav_items do |t|
      t.string     :title,                    null: false
      t.integer    :url_type, default: 0,     null: false
      t.references :url_page
      t.string     :url_text
      t.integer    :prior,    default: 9,     null: false
      t.boolean    :hided,    default: false, null: false

      t.timestamps null: false
    end
    add_index :nav_items, :prior
    add_index :nav_items, :hided
    add_foreign_key :nav_items, :pages, column: :url_page_id, on_delete: :cascade
  end
end
