# -*- encoding : utf-8 -*-
ActiveAdmin.register MainNavItem do

  config.sort_order = "prior_asc"
  config.batch_actions = true

  menu priority: 2, parent: "Сайт"

  filter :title
  filter :url_type, as: :select, collection: MainNavItem.url_type_variants
  filter :hided

  index download_links: false do
    selectable_column
    column :title
    column(:url) { |mni| link_to mni.url, mni.url, target: "_blank" }
    column :prior
    column(:hided) { |mni| mni.hided? ? t('yep') : t('nope') }
    default_actions
  end

  show do |main_nav_item|
    attributes_table do
      row :title
      row(:url) { link_to main_nav_item.url,
                          main_nav_item.url,
                          target: "_blank" }
      row(:url_type) { main_nav_item.url_type_humanized }
      row :url_text if main_nav_item.url_type == 0
      row :url_page if main_nav_item.url_type == 1
    end
    active_admin_comments
  end

  sidebar 'Дополнительные данные', only: :show do
    attributes_table_for resource do
      row :hided do
        resource.hided? ? t('yep') : t('nope')
      end
      row :prior
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "" do
      f.input :title
      f.input :url_type,
              as: :radio,
              collection: MainNavItem.url_type_variants,
              include_blank: false
      f.input :url_page,
              collection: content_pages_tree_ordered_collection,
              input_html: { :class => 'chzn-select' }
      f.input :url_text, hint: "Если вы хотите указать ссылку на страницу этого сайта, например \"Контакты\", то нужно указывать или полную ссылку, например \"http://oo.prima-tv.ru/contacts\", или путь к ссылке, начинающийся с символа \"/\" - \"/contacts\""
      f.input :prior, hint: "Меньше значение => Раньше в списке"
      f.input :hided
    end
    f.actions
  end
end