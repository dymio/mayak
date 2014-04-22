# -*- encoding : utf-8 -*-
ActiveAdmin.register NewsItem do     
  menu :priority => 3, :parent => 'Сайт'

  index do                            
    column :title                     
    column :created_at
    default_actions
  end                                                

  form do |f|                         
    f.inputs "" do       
      f.input :title
      f.input :slug
      f.input :lead, input_html: { :class => 'editor' }
      f.input :body, input_html: { :class => 'editor' }
      f.input :hided
    end                               
    f.actions                         
  end                                 
end                                   
