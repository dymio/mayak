# -*- encoding : utf-8 -*-
ActiveAdmin.register SiteSetting do

  config.sort_order = "id_asc"
  config.batch_actions = false

  actions :all, :except => [:new, :create, :show, :destroy]

  controller do
    def scoped_collection
      SiteSetting.where(hided: false)
    end
  end

  menu priority: 19

  index download_links: false do |sset|
    column :name do |sset|
      (sset.name.to_s + "<br>" +
       "<small style=\"font-size:80%;color:grey;\">" + sset.descr.to_s +
       "</small>").html_safe
    end
    column(:value) { |sset| sset.humanized_value }
    column "" do |sset|
      link_to I18n.translate(:edit, scope: :active_admin),
              edit_admin_site_setting_path(sset)
    end
  end

  filter :name

  form do |f|
    f.inputs f.object.name do
      case f.object.val_type
      when 1 # boolean
        f.input :value, as: :boolean, label: t('yep')
      when 2 # number
        f.input :value, as: :number
      # TODO datetime inputs value setting
      # when 3 # datetime
      #   f.input :value, as: :datetime
      when 4 # content page
        f.input :value,
                as: :select,
                collection: options_for_select(content_pages_tree_ordered_collection, (f.object.value ? f.object.value.id : nil) )
      else
        f.input :value
      end
    end
    f.actions
  end

  sidebar 'О настройках' do
    para "Каждая настройка сайта влияет на его работу более или менее. За что отвечает каждая настройка вы можете узнать в описании."
    para "В связи с тем, что настройки очень сильно связаны с работоспособностью сайта, вы не можете удалить их или редактировать что-либо, кроме их значений. Если вы считаете, что вам необходимы еще какие-либо настройки или нужно изменить название или описание существующей настройки - обратитесь к разработчику сайта."
  end

end