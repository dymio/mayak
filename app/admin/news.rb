ActiveAdmin.register News do
  permit_params :title, :slug, :published_at,
                :preview, :preview_cache, :remove_preview,
                :intro, :body, :hided,
                :no_title_postfix, :seo_title, :seo_descr, :seo_keywords

  ### Setting up the menu element of this page
  menu priority: 3 #, parent: "Blog"

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

    panel I18n.t("activerecord.models.static_file", count: 1.2) do
      if news.static_files.any?
        table_for news.static_files do
          column I18n.t('activerecord.attributes.static_file.filetype'), :filetype do |sf|
            if sf.filetype == "img"
              image_tag sf.file.url, size: "32x32"
            else
              span(class: "file-icon #{sf.filetype}")
            end
          end
          column I18n.t('activerecord.attributes.static_file.url'), :url do |sf|
            [ "#{sf.file.url.split('/')[0..-2].join('/')}/",
              "<b>#{sf.file.url.split("/").last}</b>" ].join.html_safe
          end
          column I18n.t('activerecord.attributes.static_file.size'), :size
          column nil do |sf|
            link_to I18n.t('active_admin.delete'),
                    admin_static_file_path(sf, format: "json"),
                    method: :delete,
                    class: 'delete-static-file',
                    data: { confirm: I18n.t('active_admin.delete_confirmation') },
                    remote: true
            # TODO make line removal when remote deletion is over
          end
        end
      end
      div do
        semantic_form_for(StaticFile.new(holder: news), url: admin_static_files_path) do |f|
          [ f.inputs(name: "Загрузить новый файл") do
              [
                f.input(:holder_type, as: :hidden),
                f.input(:holder_id, as: :hidden),
                f.input(:file)
              ].join.html_safe
            end,
            f.actions { f.action(:submit, label: "Загрузить") }
            ].join.html_safe
        end
      end
    end
  end

  sidebar 'Дополнительные данные', only: :show do
    attributes_table_for news do
      row(:hided) { news.hided? ? t('yep') : t('nope') }
      row :created_at
      row :updated_at
    end
  end

## FORM

  form do |f|
    f.inputs "" do

      f.input :title
      f.input :slug, hint: I18n.t('active_admin.hints.slug').html_safe
      f.input :published_at

      f.input :preview, hint:
        [ "Изображение будет уменьшено до размеров 280 на 150 пикселей, если оно большего размера.",
          f.object.preview? ? "<br>Текущее изображение:<br>#{image_tag(f.object.preview.url)}" : ""
        ].join.html_safe
      f.input :preview_cache, as: :hidden
      f.input :remove_preview, as: :boolean

      f.input :intro, input_html: { rows: 4  }
      f.input :body, input_html: { class: 'editor',
                                   'data-type' => 'News',
                                   'data-id' => f.object.id }
      f.input :hided
    end

    Seo::FormtasticSeoFieldset::build f
    
    f.actions
  end

end