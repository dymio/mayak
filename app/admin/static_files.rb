ActiveAdmin.register StaticFile do
  permit_params :file, :holder_type, :holder_id

  ### Disable some actions
  # actions :all, except: [:new]

  ### Setting up the menu element of this page
  menu false

  ### Custom Controller Actions
  collection_action :upload, method: :post do
    sf = StaticFile.new
    sf.file = params[:file]
    if params[:holder_id].present?
      sf.holder_type = params[:holder_type]
      sf.holder_id = params[:holder_id]
    end
    if sf.save
      render json: { filelink: sf.file.url, filename: sf.name }
    else
      render json: { error: "Ошибка при загрузке" }
    end
  end

## INDEX

  ### Index page scopes
  scope "Все", :all, default: true
  scope "Без владельца", :holderless

  ### Index page filters
  filter :name
  filter :size
  filter :created_at
  filter :updated_at

  ### Index as table
  index download_links: false do
    selectable_column
    column :name, sortable: :name do |sf|
      link_to sf.name, admin_static_file_path(sf)
    end
    column :filetype
    column :size
    column :holder, sortable: :holder_type do |sf|
      if sf.holder.present?
        [ I18n.t("activerecord.models.#{sf.holder_type.underscore}", count: 1),
          ": ",
          auto_link(sf.holder) ].join.html_safe
      end
    end
    actions
  end

## SHOW

  show do
    attributes_table do
      row(:url) { static_file.file.url }
      row :filetype
      row :size
      row :holder do
        if static_file.holder.present?
          [ I18n.t("activerecord.models.#{static_file.holder_type.underscore}",
                   count: 1),
            ": ",
            auto_link(static_file.holder) ].join.html_safe
        end
      end
      row :file do
        if static_file.image?
          image_tag(static_file.file.url)
        else
          a href: static_file.file.url, target: "_blank" do
            span(class: "file-icon #{static_file.filetype}")
            span static_file.name
          end
        end
      end
      row :created_at
      row :updated_at
    end
  end

## FORM

  form html: { multipart: true } do |f|
    f.inputs "" do
      f.input :file, hint: f.object.file? ? "Загружен файл #{f.object.name}" : nil
      f.input :file_cache, as: :hidden
    end
    f.actions
  end

end
