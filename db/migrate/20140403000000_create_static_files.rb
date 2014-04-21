class CreateStaticFiles < ActiveRecord::Migration
  def change
    create_table :static_files do |t|
      t.string :file, null: false
      t.timestamps
    end
  end
end
