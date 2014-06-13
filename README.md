Mayak Rails Website Template
============================

Mayak - is simple Rails application made for fast start of a common web-project. I call it 'site template' because rails [application templates](http://guides.rubyonrails.org/rails_application_templates.html) already exists. Website template gives you major parts of (almost) any website:

- admin panel;
- content pages;
- navigation items;
- settings;
- static files upload;
- news;


TODO list
---------

- comment most of favicons (and in html-css-template too)(and correct codenohito book)

- add facebook app id to settings (?)

- add bodyend_codes to settings

- приделать иконки файлов (основные: изображения, документы, видео и т.п.)
- переделать статичные файлы в систему обычной загрузки в папку, без хранения в БД

- группы для настроек сайта

- взять SiteMap из grandzagran

- оптимизировать картинки для demo (задать им верные размеры)
- указать источник информации на страницах
- diverse style file for default styles and styles for demo
- make demo data

- create tests

- put all russian text to I18n locale files

- make other TODO's in the code

- add example model and active_admin model files
- Slider


Demo
----
As demo we made website of russian animation.
История русской анимации ( Инфа из http://en.wikipedia.org/wiki/History_of_Russian_animation )
  Разбивка по периодам
    подразделы об отдельных мультфильмах, желательно с youtube видео
Ресурсы
  http://www.pinterest.com/hashinotamoto/russian-animation/
  http://www.hoodedutilitarian.com/2013/08/russian-animation/
  http://editthis.info/animatsiya/List_of_Russian_animation_subtitled_in_English
  http://animationstories.wordpress.com/
  https://www.facebook.com/russiananimationpage
  http://en.wikipedia.org/wiki/Masters_of_Russian_Animation
  http://www.tumblr.com/tagged/russian-animation
  http://www.youtube.com/user/Soyuzmult
Новости
  http://www.kinopoisk.ru/top/navigator/m_act%5Bcountry%5D/2,2/m_act%5Bnum_vote%5D/100/m_act%5Brating%5D/1:/m_act%5Bcountry_and%5D/on/m_act%5Brestriction%5D/0+/m_act%5Bis_mult%5D/on/order/premiere_ru/#results
Контакты


Used software
-------------
Many brilliant ruby gems (check versions in Gemfile):

- Ruby on Rails;
- ActiveAdmin for admin panel;
- Kaminari for pagination;
- etc.;

Also we use:

- [normalize.css](http://necolas.github.io/normalize.css/) v2.1.3
- [Redactor](http://imperavi.com/redactor/) v9.1.4
- [Chosen](http://harvesthq.github.io/chosen/) v1.0.0
- [Dymio's HTML CSS template](https://github.com/dymio/html-css-template) v0.9
- [Popapilus jQuery plugin](https://github.com/dymio/popapilus) v 0.9


Installation
------------
Clone code of this project.

Make sure that you have Ruby version, writed in `.ruby-version` file.

If you use RVM add .ruby-gemset file ([read about it](http://stackoverflow.com/questions/15708916/use-rvmrc-or-ruby-version-file-to-set-a-project-gemset-with-rvm)).

Replace all includes of string 'Mayak' in project with name of your project. Files wit this string in:

  - config.ru
  - Rakefile
  - config/application.rb
  - config/environment.rb
  - config/routes.rb
  - config/environments/development.rb
  - config/environments/production.rb
  - config/environments/test.rb
  - config/initializers/secret_token.rb
  - config/initializers/session_store.rb

Next you need to replace secret key in file `config/initializers/secret_token.rb`. You can use `bundle exec rake secret` or [some generators](http://www.andrewscompanies.com/tools/wep.asp) for generate it. In the file `config/initializers/session_store.rb` replace session key `_mayak_session` with your project prefix.

In the file `config/initializers/active_admin.rb` replace `config.site_title` with your site title.

In the file `config/initializers/devise.rb` replace value of `config.mailer_sender`.

You also need create file `config/database.yml` for database connection. I made file `config/database-example.yml` for example.

In the first migration file (`db/migrate/20140401000000_devise_create_admin_users.rb`) you can change email and password of admin user. By default it admin@mayak.com with password 'master'.

In the migration file of site settings (`db/migrate/20140405000000_create_site_settings.rb`) you can change default settings values and add new settings.

Right now you can remove components you do not need...

When done, run:

  - `bundle install`
  - `bundle exec rake db:create db:migrate`

Demo data you can install wit command:

  - `bundle exec rake db:seed`

And when you finish installation pleace replace this file content with description of your project.
