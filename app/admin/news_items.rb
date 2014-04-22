# -*- encoding : utf-8 -*-
ActiveAdmin.register NewsItem do     
  menu :priority => 18, :parent => 'Сайт'

  index do                            
    column :title                     
    column :created_at
    default_actions                   
  end                                 

  filter :email                       

  form do |f|                         
    f.inputs "" do       
      f.input :title
      f.input :slug
      f.input :lead
      f.input :content, input_html: { :class => 'editor' }
    end                               
    f.actions                         
  end                                 
end                                   
