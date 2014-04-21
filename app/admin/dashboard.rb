# -*- encoding : utf-8 -*-
ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    # div :class => "blank_slate_container", :id => "dashboard_default_message" do
    #   span :class => "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end
    
    columns do
      column do
        panel "Последние редактированные страницы" do
          table_for ContentPage.visibles.order('updated_at desc').limit(10) do
            column(I18n.t('activerecord.attributes.content_page.title')) do |cp|
              link_to cp.title_with_parents, admin_content_page_path(cp)
            end
            column(I18n.t('activerecord.attributes.content_page.slug')) do |cp|
              cp.full_slug
            end
            column(I18n.t('activerecord.attributes.content_page.behavior_type')) do |cp|
              cp.behavior_type_humanized
            end
          end
        end
      end

      column do
        panel "Информация" do
          para "Добро пожаловать в панель управления сайтом, построенном на основе Mayak Rails Website Template. Надеюсь вам понравиться пользоваться моей разработкой и она вам поможет в вашей работе."
          para do
            ("Если у вас будут ко мне вопросы или предложения по улучшению Mayak, смело пишите по адресу " +
             mail_to("mstrdymio@gmail.com")).html_safe
          end
          para do
            ("Исходный код проекта Mayak Rails Site Template выложен на Гитхабе - " +
             link_to("dymio/mayak", "http://github.com/dymio/mayak")).html_safe
          end
        end
      end
    end # columns

  end # content
end
