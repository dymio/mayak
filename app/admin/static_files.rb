# -*- encoding : utf-8 -*-
ActiveAdmin.register StaticFile do

  config.batch_actions = true
  config.sort_order = "created_at_asc"

  menu parent: 'Сайт', priority: 11

  config.filters = false

  collection_action :upload_static_file, :method => :post do
    stfile = StaticFile.new
    stfile.file = params[:file]
    stfile.save
    render :json => { filelink: stfile.file.url }
  end

  index download_links: false do
    selectable_column
    column :file do |sf|
      link_to sf.file_name, admin_static_file_path(sf)
    end
    column(:url) { |sf| link_to sf.file.url, sf.file.url, target: '_blank' }
    default_actions
  end

  show do |static_file|
    panel "Файл" do
      if static_file.image_here?
        div image_tag(static_file.file.url), :class => "image-guard"
      else
        "<p style='margin-top:28px;font-size:38px;font-weight:bold;'>#{static_file.file_name}</p>".html_safe
      end
    end
    active_admin_comments
  end

  sidebar 'Данные', only: :show do
    attributes_table_for static_file do
      row :url do
        link_to static_file.file.url, static_file.file.url, target: '_blank'
      end
      row :size do
        (static_file.file.file.size / 1024).to_s + " Кбайт"
      end
      row :created_at
      row :updated_at
    end
  end

  sidebar 'Информация' do
    para 'Вы можете загружать произвольные файлы и потом использовать их в любых целях - например, в контентных страницах.'
    para 'Для этого нужно скопировать ссылку файла и использовать её при добавления файла в редакторе (например, в качестве src аттрибута для тэга img, если это изображение).'
    para 'Изображения, загруженные из редактора, так же отображаются в этом списке.'
  end

  form do |f|
    f.inputs "" do
      f.input :file
    end
    f.actions
  end

end
