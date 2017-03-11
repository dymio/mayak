class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string  :title
      t.string  :path,                    null: false
      t.text    :body
      t.text    :seodata
      t.integer :prior,   default: 9,     null: false
      t.boolean :hided,   default: false, null: false

      t.timestamps null: false
    end
    add_index :pages, :path, unique: true
    add_index :pages, :prior
    add_index :pages, :hided
  end
end
