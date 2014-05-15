class CreateContentPages < ActiveRecord::Migration
  def migrate(direction)
    super
    ContentPage.create!(id: 1, title: "Homepage", slug: "", body: "<p>Welcome!</p>", prior: 1) if direction == :up
  end

  def change
    create_table :content_pages do |t|
      t.string  :title
      t.string  :slug,          null: false
      t.string  :ancestry
      t.boolean :immortal
      t.integer :behavior_type, null: false, default: 0
      t.references :rct_page
      t.string  :rct_lnk
      t.text    :body
      t.text    :seodata
      t.integer :prior,         null: false, default: 10
      t.boolean :hided,         null: false, default: false

      t.timestamps
    end

    add_index :content_pages, :slug
    add_index :content_pages, :ancestry
    add_index :content_pages, :prior
    add_index :content_pages, :hided
  end
end
