ActiveAdmin.register Page do
  permit_params :title, :slug, :body, :prior, :hided,
                :no_title_postfix, :seo_title, :seo_descr, :seo_keywords

  ### Setting up the menu element of this page
  menu priority: 2 #, parent: "Сайт"

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
    column :slug, sortable: :slug do |page|
      if page.home?
        link_to "/", root_path, target: '_blank'
      else
        link_to page.slug, page_path(page.slug), target: '_blank'
      end
    end
    column :prior
    column :hided
    actions
  end

## SHOW

  show do
    attributes_table do
      # TODO elements visibles for home and fixed
      unless page.home?
        row :title
        row :slug do
          link_to page.slug, page_path(page.slug), target: '_blank'
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
        f.input :slug, hint: I18n.t('active_admin.hints.slug').html_safe
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
