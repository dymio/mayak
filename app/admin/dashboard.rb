ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "Последние добавленные новости" do
          if News.any?
            table_for News.order(created_at: :desc).limit(10) do
              column :title do |news|
                link_to news.title, admin_news_path(news)
              end
              column :published_at do |news|
                I18n.l news.published_at, format: '%d %b %Y %H:%M'
              end
              column :hided
            end
          else
            para style: "margin-top:1.5em;text-align:center;font-weight:bold" do
              "На данный момент не добавлено ни одной новости."
            end
          end
        end
      end
    end # columns

    columns do
      column do
        panel "О Системе" do
          para "Сайт разработан специально под нужды вашей компании на очень " \
               "гибкой платформе, которая позволяет и добавлять новые модули "\
               "сайта, и вносить практически любые изменения в существующие."
          para do
            ( "Тут стоит поместить информацию о том, кто оказывает тех. " +
              "поддержку сайту и не забыть ссылку на " +
              link_to("их сайт", "http://dev.pro/", target: '_blank') +
              ". По вопросам использования системы или её доработки " +
              "вы можете обращаться к тому-то, оставлять сообщения о багах " +
              "там-то, все контакты " +
              link_to("вот тут", 'http://dev.pro/contacts', target: '_blank') +
              ".").html_safe
          end
        end
      end

      column do
        panel "Техническая информация" do
          para "Сайт написан на языке Ruby 2.2.3 с применением веб-фреймворка" \
               " Ruby on Rails 4.2.8. Используется СУБД PostgreSQL."
          para do
            ( "Основой для сайта является Mayak Rails Website Template. " +
              "Больше информации можно найти на сайте " +
              link_to("mayak.io", "http://mayak.io", target: '_blank') +
              ".").html_safe
          end
        end
      end
    end # columns

  end # content
end
