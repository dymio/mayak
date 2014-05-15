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

    panel "SEO параметры" do
      attributes_table_for news_item do
        row :seo_title do
          news_item.seo_title.present? ? news_item.seo_title : '<small style="color:#999">для тега title используется заголовок страницы</small>'.html_safe
        end
        row :no_title_postfix do
          news_item.no_title_postfix == '1' ? t('yep') : t('nope')
        end
        row :seo_descr
        row :seo_keywords
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
      row :published_at
    end
  end

  form do |f|
    f.inputs "" do
      f.input :title
      f.input :slug
      f.input :published_at, :as => :datepicker
      f.input :lead, input_html: { :class => 'editor' }
      f.input :body, input_html: { :class => 'editor' }
      f.input :hided
    end

    f.inputs "SEO параметры" do
      f.input :seo_title, hint: "по умолчанию используется заголовок страницы"
      f.input :no_title_postfix, as: :boolean
      f.input :seo_descr, as: :text, input_html: { rows: 2 }
      f.input :seo_keywords, as: :text, input_html: { rows: 2 }
    end
    
    f.actions
  end
end
