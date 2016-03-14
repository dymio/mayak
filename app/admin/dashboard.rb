ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "Последние добавленные Новости" do
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

      column do
        panel "О Системе" do
          para do
            [ "Добро пожаловать в панель управления сайтом, построенном на основе Mayak Rails Website Template.  ",
              "Больше информации можно найти на сайте ",
              link_to("mayak.io", "http://mayak.io"),
              ". Надеюсь вам понравится пользоваться моей разработкой и она вам поможет в вашей работе." ].join.html_safe
          end
          para do
            [ "Если у вас будут вопросы или предложения по улучшению Mayak, смело пишите ",
              link_to('issue на GitHub', 'https://github.com/dymio/mayak/issues'),
              " или лично мне на почту ",
              mail_to("mstrdymio@gmail.com") ].join.html_safe
          end
          para do
            [ "Исходный код проекта Mayak Rails Site Template выложен на GitHub - ",
             link_to("dymio/mayak", "http://github.com/dymio/mayak"),
             ". Приглашаю всех желающих присоединиться к разработке проекта, инструкция по тому как это cделать находится ",
             link_to("в описании проекта на GitHub'е", 'https://github.com/dymio/mayak#contributing'),
             "." ].join.html_safe
          end
        end
      end
    end # columns

  end # content
end
