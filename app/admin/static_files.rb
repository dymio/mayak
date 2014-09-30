ActiveAdmin.register StaticFile do
  permit_params :file, :holder_type, :holder_id

  # actions :all, except: [:new]

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

  config.filters = false

  index download_links: false do
    selectable_column
    column :display_name, sortable: false do |sf|
      link_to sf.display_name, admin_static_file_path(sf)
    end
    column :filetype, sortable: false
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
      row :filesize
      row :holder_type do
        I18n.t "activerecord.models.#{static_file.holder_type.underscore}",
               count: 1
      end
      row :holder
      row :file do
        if static_file.filetype == "img"
          div image_tag(static_file.file.url)
        else
          "<p style='margin-top:28px;font-size:38px;font-weight:bold;'>#{static_file.file_name}</p>".html_safe
        end
      end
      row :created_at
      row :updated_at
    end
  end

## FORM

  form do |f|
    f.inputs "" do
      f.input :holder_type, as: :hidden
      f.input :holder_id,   as: :hidden
      f.input :file, hint: f.object.file? ? "Загружен файл #{f.object.display_name}" : nil
      f.input :file_cache, as: :hidden
    end
    f.actions
  end

end
