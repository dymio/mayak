# -*- encoding : utf-8 -*-
ActiveAdmin.register NewsItem do     
  menu :priority => 3, :parent => 'Сайт'

  index do                            
    column :title                     
    column :created_at
    default_actions
  end                                                

  show do |news_item|
    attributes_table do
      row :title
      row :slug
      row :lead do
        news_item.lead.html_safe
      end
      row :body do
        news_item.body.html_safe
      end
    end
    active_admin_comments
  end

  sidebar 'Дополнительные данные', only: :show do
    attributes_table_for resource do
      row :hided do
        resource.hided? ? t('yep') : t('nope')
      end
      row :created_at
      row :updated_at
      row :date
    end
  end

  form do |f|                         
    f.inputs "" do       
      f.input :title
      f.input :slug
      f.input :date, :as => :datepicker
      f.input :lead, input_html: { :class => 'editor' }
      f.input :body, input_html: { :class => 'editor' }
      f.input :hided
    end                               
    f.actions                         
  end                                 
end                                   
