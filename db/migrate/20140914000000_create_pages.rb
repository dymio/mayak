class CreatePages < ActiveRecord::Migration
  def migrate(direction)
    super
    Page.create!(title: "Главная", slug: "", body: "<p>Добро пожаловать!</p>", prior: 1) if direction == :up
  end

  def change
    create_table :pages do |t|
      t.string  :title
      t.string  :slug,                    null: false
      t.boolean :fixed
      t.text    :body
      t.text    :seodata
      t.integer :prior,   default: 9,     null: false
      t.boolean :hided,   default: false, null: false

      t.timestamps null: false
    end
    add_index :pages, :slug
    add_index :pages, :prior
    add_index :pages, :hided
  end
end
