class CreateStaticFiles < ActiveRecord::Migration
  def change
    create_table :static_files do |t|
      t.references :holder,   polymorphic: true, index: true
      t.string     :file,     null: false
      t.string     :filetype
      t.string     :name
      t.float      :size

      t.timestamps null: false
    end
  end
end
