ActiveAdmin.register StaticFile do
  permit_params :file, :holder_type, :holder_id

  ### Disable some actions
  # actions :all, except: [:new]

  ### Setting up the menu element of this page
  menu false

  ### Custom Controller Actions
  # TODO for editor
  # collection_action :upload, :method => :post do
  #   stfile = StaticFile.new
  #   stfile.file = params[:file]
  #   stfile.save
  #   render :json => { filelink: stfile.file.url }
  # end

## INDEX

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
    column :holder_type, sortable: false do |sf|
      I18n.t("activerecord.models.#{sf.holder_type.underscore}", count: 1)
    end
    column :holder, sortable: false
    actions
  end

## SHOW

  show do
    attributes_table do
      row(:url) { static_file.file.url }
      row :filetype
      row :size
      row :holder_type do
        I18n.t "activerecord.models.#{static_file.holder_type.underscore}",
               count: 1
      end
      row :holder
      row :file do
        if static_file.filetype == "img"
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

  form do |f|
    f.inputs "" do
      f.input :holder_type#, as: :hidden
      f.input :holder_id#,   as: :hidden
      f.input :file, hint: f.object.file? ? "Загружен файл #{f.object.name}" : nil
      f.input :file_cache, as: :hidden
    end
    f.actions
  end

end
