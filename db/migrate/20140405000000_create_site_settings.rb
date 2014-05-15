# -*- encoding : utf-8 -*-
class CreateSiteSettings < ActiveRecord::Migration
  def migrate(direction)
    super
    if direction == :up
      SiteSetting.create!([
        {
          ident: "site_name",
          name: "Название сайта",
          descr: "Название сайта используется как заголовок сайта на главной странице и как часть заголовка на всех остальных",
          set_val: "Mayak Rails Website Template"
        }
      ])
    end
  end

  def change
    create_table :site_settings do |t|
      t.string  :ident,    null: false
      t.string  :name
      t.string  :descr
      t.integer :val_type
      t.text    :set_val
      t.boolean :hided,    null: false, default: false

      t.timestamps
    end
    add_index :site_settings, :ident
    add_index :site_settings, :hided
  end
end
