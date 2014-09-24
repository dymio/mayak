class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string  :ident,                  null: false
      t.string  :name
      t.text    :descr
      t.integer :vtype
      t.text    :val
      t.string  :group
      t.boolean :often
      t.boolean :hidden, default: false, null: false

      t.timestamps
    end

    add_index :settings, :ident
    add_index :settings, :often
    add_index :settings, :hidden
  end
end
