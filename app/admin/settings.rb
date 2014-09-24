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
    column(:value) { |sset| sset.humanized_value }
    actions
  end

## FORM

  form do |f|
    f.inputs f.object.name do
      case f.object.vtype
      when Setting::VTYPE_BOOLEAN
        f.input :value, as: :boolean, label: "#{f.object.name}?"
      when Setting::VTYPE_TEXT
        f.input :value, as: :text
      # when Setting::VTYPE_MAP_POINT # TODO
      #   f.input :value
      # when Setting::VTYPE_PAGE # TODO
      #   f.input :value,
      #           as: :select,
      #           collection: options_for_select(Page.all, (f.object.value ? f.object.value.id : nil) )
      else
        f.input :value
      end
    end
    f.actions
  end

end