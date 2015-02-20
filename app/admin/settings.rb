ActiveAdmin.register Setting do
  permit_params :value

  ### Disable some actions
  actions :all, except: [:new, :create, :show, :destroy]

  ### Setting up the menu element of this page
  menu priority: 19

## INDEX

  ### Index page Configuration
  config.filters = false
  config.batch_actions = false
  config.paginate = false
  config.sort_order = 'id_asc'

  ### Override `scoped_collection` for another or extended index collection
  controller do
    def scoped_collection
      super.visibles
    end
  end

  ### Index as table
  index download_links: false do
    column :name, sortable: :name do |sset|
      [ sset.name.to_s,
        "<br>",
        "<small style=\"font-size:80%;color:grey;\">",
        sset.descr.to_s,
        "</small>" ].join.html_safe
    end
    column(:value) do |sset|
      if sset.vtype == Setting::VTYPE_FILE && sset.static_file.present?
        link_to static_file_image(sset.static_file, true, :big_thumb),
                sset.static_file.file.url,
                target: "_blank"
      else
        sset.humanized_value
      end
    end
    actions
  end

## FORM

  form html: { multipart: true } do |f|
    f.inputs f.object.name do
      case f.object.vtype
      when Setting::VTYPE_BOOLEAN
        f.input :value, as: :boolean, label: "#{f.object.name}?"
      when Setting::VTYPE_TEXT
        f.input :value, as: :text
      when Setting::VTYPE_FILE
        f.input :value, as: :file,
                        hint: ( f.object.static_file.present? ?
                                "Загружен файл #{f.object.static_file.name}" :
                                nil )
      # when Setting::VTYPE_MAP_POINT
      #   f.input :value
      when Setting::VTYPE_PAGE
        f.input :value,
                  as: :select,
                  collection: Page.all.collect { |p| [ p.title, p.id ] }
      else
        f.input :value
      end
    end
    f.actions
  end

end
