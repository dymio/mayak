ActiveAdmin.register Page do
  permit_params :title, :path, :body, :prior, :hided,
                :no_title_postfix, :seo_title, :seo_descr, :seo_keywords

  ### Setting up the menu element of this page
  menu priority: 2 #, parent: "Сайт"

  ### Action items (buttons on the top right of the page)
  action_item only: :show do
    link_to 'Создать новую', new_admin_page_path
  end

## INDEX

  ### Index page Configuration
  config.filters = false
  config.batch_actions = false
  config.paginate = false
  config.sort_order = 'prior_asc'

  ### Index page scopes
  scope "Все", :all, default: true
  scope "Видимые на сайте", :visibles # renames model scope ':visibles'

  ### Index as table
  index download_links: false do
    column :title
    column :path, sortable: :path do |page|
      if page.home?
        link_to "/", root_path, target: '_blank'
      else
        link_to page.path, page_path(page.path), target: '_blank'
      end
    end
    column :prior
    column :hided
    actions
  end

## SHOW

  show do
    attributes_table do
      unless page.home?
        row :title
        row :path do
          link_to page.path, page_path(page.path), target: '_blank'
        end
      end
      row(:body) { raw page.body }
    end

    seo_panel_for page, hide_seo_title: page.home?,
                        hide_no_title_postfix: page.home?

    static_files_for page

  end

## SIDEBARS

  sidebar 'Дополнительные данные', only: :show do
    attributes_table_for page do
      row(:hided) { page.hided? ? t('yep') : t('nope') }
      row :prior
      row :created_at
      row :updated_at
    end
  end

## FORM

  form do |f|
    f.inputs '' do
      f.input :title unless page.home?
      unless page.home? || page.fixed?
        f.input :path, hint: 'Уникальная часть URL-адреса, идущая после домена, которая указывает на эту страницу. Например, для адреса `example.com/information/delivery` часть `information/delivery` &mdash; URL-путь к странице. <a href="https://ru.wikipedia.org/wiki/URL" target="_blank">Подробнее на Википедии</a>.<br>Если оставить поле пустым, то URL-путь будет сгенерирован на основе заголовка.'.html_safe
      end
      f.input :body, input_html: { class: 'editor',
                                   'data-type' => f.object.class.name,
                                   'data-id' => f.object.id }
      f.input :prior, hint: "Меньше значение => раньше в списке"
      f.input :hided unless page.home? || page.fixed?
    end

    Seo::FormtasticSeoFieldset::build f, hide_seo_title: f.object.home?,
                                         hide_no_title_postfix: f.object.home?

    f.actions
  end

end
