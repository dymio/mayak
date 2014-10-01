ActiveAdmin.register NavItem do
  permit_params :title, :url_type, :url_page_id, :url_text, :prior, :hided

  ### Disable some actions
  actions :all, except: [:show]

  ### Setting up the menu element of this page
  menu priority: 4 #, parent: "Сайт"

## INDEX

  ### Index page Configuration
  config.batch_actions = false
  config.paginate = false
  config.sort_order = 'prior_asc'

  ### Index page scopes
  scope "Все", :all, default: true
  scope "Видимые на сайте", :visibles

  ### Index page filters
  filter :title
  filter :url_type, as: :select, collection: NavItem.url_type_variants

  ### Index as table
  index download_links: false do
    column :title
    column(:url) { |ni| link_to ni.url, ni.url, target: "_blank" }
    column :prior
    column :hided
    actions
  end

## SHOW

  # show do
  #   attributes_table do
  #     row :title
  #     row(:url) { link_to nav_item.url, nav_item.url, target: "_blank" }
  #     row(:url_type) { nav_item.url_type_humanized }
  #     row :url_text if nav_item.url_type == 0
  #     row :url_page if nav_item.url_type == 1
  #   end
  # end

## SIDEBARS

  sidebar 'Дополнительные данные', only: :show do
    attributes_table_for nav_item do
      row(:hided) { nav_item.hided? ? t('yep') : t('nope') }
      row :prior
    end
  end

## FORM

  form do |f|
    f.inputs '' do
      f.input :title
      f.input :url_type, as: :radio,
                         collection: NavItem.url_type_variants,
                         include_blank: false
      f.input :url_page, collection: Page.all.collect { |p| [ p.title, p.id ] },
                         input_html: { class: 'chzn-select' }
      f.input :url_text, hint: "Если вы хотите указать ссылку на страницу этого сайта, например \"Контакты\", то нужно указывать или полную ссылку, например \"http://proektmarketing.ru/contacts\", или путь к ссылке, начинающийся с символа \"/\" - \"/contacts\""
      f.input :prior, hint: "Меньше значение => раньше в списке"
      f.input :hided
    end
    f.actions
  end
end
