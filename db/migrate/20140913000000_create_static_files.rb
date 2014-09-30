class CreateStaticFiles < ActiveRecord::Migration
  def change
    create_table :static_files do |t|
      t.references :holder,    polymorphic: true, index: true
      t.string     :file,      null: false
      t.string     :filetype
      t.float      :filesize

      t.timestamps
    end
  end
end
