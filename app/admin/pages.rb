ActiveAdmin.register Page do
  permit_params :title, :path, :body, :prior, :hided,
                :no_title_postfix, :seo_title, :seo_descr, :seo_keywords

  ### Setting up the menu element of this page
  menu priority: 2 #, parent: "Сайт"

  ### Action items (buttons on the top right of the page)
  action_item :create_new, only: :show do
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

    actions defaults: false do |resource|
      if controller.action_methods.include?('show') &&
         authorized?(ActiveAdmin::Auth::READ, resource)
        item I18n.t('active_admin.view'), resource_path(resource),
                                          class: "view_link member_link",
                                          title: I18n.t('active_admin.view')
      end
      if controller.action_methods.include?('edit') &&
         authorized?(ActiveAdmin::Auth::UPDATE, resource)
        item I18n.t('active_admin.edit'), edit_resource_path(resource),
                                          class: "edit_link member_link",
                                          title: I18n.t('active_admin.edit')
      end
      if controller.action_methods.include?('destroy') &&
         authorized?(ActiveAdmin::Auth::DESTROY, resource) &&
         !resource.home? && !resource.fixed?
        item I18n.t('active_admin.delete'),
             resource_path(resource),
             class: "delete_link member_link",
             title: I18n.t('active_admin.delete'),
             method: :delete,
             data: {confirm: I18n.t('active_admin.delete_confirmation')}
      end
    end
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
    if page.fixed?
      para '<span style="text-decoration:uppercase;font-weight:bold">'\
           'Страница зафиксирована</span>'.html_safe
      para 'Эта страница специального назначения, она <b>зафиксирована</b>. '\
           'Это значит, что её нельзя ни удалить, ни скрыть, ни поменять '\
           'её URL-путь.'.html_safe
    end
  end

## FORM

  form do |f|
    f.inputs '' do
      f.input :title unless page.home?
      unless page.home? || page.fixed?
        f.input :path, hint: I18n.t('active_admin.hints.path').html_safe
      end
      f.input :body, input_html: { class: 'editor',
                                   data: { type: f.object.class.name, id: f.object.id } }
      f.input :prior, hint: "Меньше значение => раньше в списке"
      f.input :hided unless page.home? || page.fixed?
    end

    Seo::FormtasticSeoFieldset::build f, hide_seo_title: f.object.home?,
                                         hide_no_title_postfix: f.object.home?

    f.actions
  end

end
