class CreateSettings < ActiveRecord::Migration
  def migrate(direction)
    super
    # Create a default settings
    if direction == :up
      Setting.create([
        { ident: "site_name",
          name: "Название сайта",
          descr: "Название сайта отображается в заголовке страниц сайта",
          val: "Mayak",
          often: true },
        { ident: "manager_email",
          name: "Email менеджера",
          descr: "Адрес электронной почты менеджера, на который будут отправляться письма с обратной связью" },
        { ident: "bodyend_codes",
          name: "HTML перед закрывающим тегом body",
          descr: "Используется для размещения кодов счётчиков и других технических задач",
          vtype: Setting::VTYPE_TEXT,
          often: true }
      ])
    end
  end

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

      t.timestamps null: false
    end
    add_index :settings, :ident
    add_index :settings, :often
    add_index :settings, :hidden
  end
end
