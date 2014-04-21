# -*- encoding : utf-8 -*-
class CreateSiteSettings < ActiveRecord::Migration
  def migrate(direction)
    super
    if direction == :up
      SiteSetting.create!([
        {
          ident: "default_page_title",
          name: "Заголовок сайта по умолчанию",
          descr: "Отображается на главной странице и на всех страницах, после указанного заголовка этой страницы",
          set_val: "Mayak Rails Website Template"
        },
        {
          ident: "default_page_description",
          name: "Описание сайта по умолчанию",
          descr: "Содержание тэга description на главной странице и на всех страницах, где не указано иное",
          set_val: "The page of Mayak Rails Website Template"
        },
        {
          ident: "default_page_keywords",
          name: "Ключевые слова сайта по умолчанию",
          descr: "Содержание тэга keywords на главной странице и на всех страницах, где не указано иное",
          set_val: "ruby, rails, mayak, html, website, template, html5, css3"
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
