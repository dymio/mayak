ActiveAdmin.register News do
  permit_params :title, :slug, :published_at,
                :preview, :preview_cache, :remove_preview,
                :intro, :body, :hided,
                :no_title_postfix, :seo_title, :seo_descr, :seo_keywords

  ### Setting up the menu element of this page
  menu priority: 3 #, parent: "Blog"

  ### Action items (buttons on the top right of the page)
  action_item only: :show do
    link_to 'Создать новую', new_admin_news_path
  end

## INDEX

  ### Index page Configuration
  config.per_page = 20
  config.sort_order = 'published_at_desc'

  ### Index page scopes
  scope "Все", :all, default: true
  scope "Видимые на сайте", :visibles

  ### Index page filters
  filter :title
  filter :slug
  filter :published_at
  filter :intro_or_body_cont, as: :string, label: 'В тексте (интро или содержании)'
  filter :hided

  ### Index page batch actions
  batch_action :show, confirm: "Уверены?" do |ids|
    News.find(ids).each do |news|
      news.update(hided: false)
    end
    redirect_to collection_path, alert: "У указанных новостей убран флаг скрытия."
  end
  batch_action :hide, confirm: "Уверены?" do |ids|
    News.find(ids).each do |news|
      news.update(hided: true)
    end
    redirect_to collection_path, alert: "Указанные новости были скрыты."
  end

  ### Index as table
  index download_links: false do
    selectable_column
    column :title
    column "slug", :slug, sortable: :slug do |news|
      link_to news.slug, news_path(news.slug), target: '_blank'
    end
    column :published_at, sortable: :published_at do |news|
      I18n.l news.published_at, format: '%d %b %Y %H:%M'
    end
    column :hided
    actions
  end

## SHOW

  show do

    attributes_table do
      row :title
      row(:slug) { link_to news.slug, news_path(news.slug), target: '_blank' }
      row :published_at
      row(:preview) { image_tag(news.preview.url) unless news.preview.blank? }
      row :intro
      row(:body) { raw news.body }
    end

    seo_panel_for news

    static_files_for news
  end

  sidebar 'Дополнительные данные', only: :show do
    attributes_table_for news do
      row(:hided) { news.hided? ? t('yep') : t('nope') }
      row :created_at
      row :updated_at
    end
  end

## FORM

  form html: { multipart: true } do |f|
    f.inputs "" do

      f.input :title
      f.input :slug, hint: I18n.t('active_admin.hints.slug').html_safe
      f.input :published_at, start_year: 1971

      f.input :preview, hint:
        [ "Изображение будет уменьшено до размеров 280 на 150 пикселей, если оно большего размера.",
          f.object.preview? ? "<br>Текущее изображение:<br>#{image_tag(f.object.preview.url)}" : ""
        ].join.html_safe
      f.input :preview_cache, as: :hidden
      f.input :remove_preview, as: :boolean

      f.input :intro, input_html: { rows: 4  }
      f.input :body, input_html: { class: 'editor',
                                   'data-type' => f.object.class.name,
                                   'data-id' => f.object.id }
      f.input :hided
    end

    Seo::FormtasticSeoFieldset::build f

    f.actions
  end

end