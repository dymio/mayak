Mayak Rails Website Template
============================

Mayak - is simple Rails application made for fast start of a common web-project. I call it 'site template' because rails [application templates](http://guides.rubyonrails.org/rails_application_templates.html) already exists. Website template gives you major components of (almost) any website:

Attention! Right now application is broken. Please use [previous stable version](https://github.com/dymio/mayak/tree/version_zero_dot_six).

* admin panel;
* pages managment;
* navigation items;
* settings;
* static files upload;
* news;

TODO update this list (by SEO at least)


Software and coventions
-----------------------

Template based on Ruby 2.1.2 and use many brilliant ruby gems (check all list and versions in Gemfile):

* Ruby on Rails;
* ActiveAdmin for admin panel;
* Kaminari for pagination;

TODO upgrade this list

Also we use:

* [normalize.css](http://necolas.github.io/normalize.css/)
* [Redactor](http://imperavi.com/redactor/)
* [Chosen](http://harvesthq.github.io/chosen/)
* [Dymio's HTML CSS template](https://github.com/dymio/html-css-template)

TODO update list (maybe remove popapilus with colorbox)

And we threat with respect of [humans.txt](http://humanstxt.org/) idea.


Installation
------------

Clone code of this project.

Make sure that you have Ruby version, writed in `.ruby-version` file.

If you use RVM, add [.ruby-gemset file](http://stackoverflow.com/questions/15708916/use-rvmrc-or-ruby-version-file-to-set-a-project-gemset-with-rvm) to the root of application.

Replace module name in `config/application.rb` file from 'Mayak' to your project name.

Set your timezone and default_locale in `config/application.rb` file.

In the file `config/initializers/session_store.rb` replace session key `_mayak_session` with your project key.

Replace all secret keys in file `config/secrets.rb`. You can use `bundle exec rake secret` or [some generators](http://www.andrewscompanies.com/tools/wep.asp) for generate it. You can use `secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>` for production if you need to hide production key from repo, but do not forget setup this ENV variable on server.

Create file `config/database.yml` for database connection. There is `config/database_example.yml` for example.

Check file `config/autoprefixer.yml` and set [settings](github.com/postcss/autoprefixer#browsers) you need.

Setting up the mailer in `config/environments/production.rb` file, if you need to sending emails from site.

Replace or remove LICENSE.txt file.

In the file `config/initializers/devise.rb` replace value of `config.mailer_sender`.

In the first migration file (`db/migrate/[TODO]devise_create_admin_users.rb`) you can change email and password of admin user. By default it admin@example.com with password 'password'.

In the file `config/initializers/active_admin.rb` replace `config.site_title` with title of your site.

Change `default-host` setting in the file `config/sitemap.rb` (and do not forget about sitemap during development).

TODO : In the migration file of site settings (`db/migrate/20140405000000_create_site_settings.rb`) you can change default settings values and add new settings.

When done, run:

  - `bundle install`
  - `bundle exec rake db:create db:migrate`

Demo data you can install wit command:

  - `bundle exec rake db:seed`

Your app ready for use, you can launch webserver with command `bundle exec rails server` and see home page at [localhost:3000](http://localhost:3000/) url.

And, when you finish installation, pleace replace this file content with description of your project.

Do not forget change `public/favicon.ico` and all icons in directory `public/ico/`, fill `public/humans.txt` with correct data and uncomment correct lines in `public/robots.txt` before publish.


License
-------
Mayak Rails Website Template is released under the [MIT License](LICENSE.txt).


Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Feel free to use code of the project as you want, [create issues](https://github.com/dymio/mayak/issues) or make a pull requests.




TODO list
---------

- change immortal to fixed

- rename ContentPage to Page and SiteSetting to Setting (check naming conflicts)

- comment most of favicons (and in html-css-template too)(and correct codenohito book)

- add facebook app id to settings (?)

- add bodyend_codes to settings

- Contacts page with feedback

- логирование изменений материалов пользователями

- приделать иконки файлов (основные: изображения, документы, видео и т.п.)
- переделать статичные файлы в систему обычной загрузки в папку, без хранения в БД

- группы для настроек сайта

- оптимизировать картинки для demo (задать им верные размеры)
- указать источник информации на страницах
- diverse style file for default styles and styles for demo
- make demo data

- create tests

- put all russian text to I18n locale files

- make other TODO's in the code

- Slider

- Try to use Nested Set instead Ancestry

- Store default SiteSettings in yaml and add they to db when load automatically

- переименовать "Контентные страницы" в "Страницы", из за immortal функции

- ссылку на файл добавить из боковой колонки на основную часть в view static_files

- add [cancan to activeadmin](https://github.com/activeadmin/activeadmin/blob/master/docs/13-authorization-adapter.md) by default



  deleted:    Capfile
  deleted:    config/deploy.rb

  deleted:    db/migrate/20140403000000_create_static_files.rb
  deleted:    db/migrate/20140404000000_create_content_pages.rb
  deleted:    db/migrate/20140405000000_create_site_settings.rb
  deleted:    db/migrate/20140406000000_create_main_nav_items.rb
  deleted:    db/migrate/20140422054828_create_news.rb

  deleted:    app/admin/content_pages.rb
  deleted:    app/assets/images/admin/content_page_types.png
  deleted:    app/controllers/content_pages_controller.rb
  deleted:    app/helpers/content_pages_helper.rb
  deleted:    app/models/active_admin/views/index_as_ancestry_roots_block.rb
  deleted:    app/models/content_page.rb
  deleted:    app/views/admin/content_pages/_index_line.html.slim
  deleted:    app/views/content_pages/_sidenav_level.html.slim
  deleted:    app/views/content_pages/show.html.slim

  deleted:    app/admin/main_mav_items.rb
  deleted:    app/models/main_nav_item.rb

  deleted:    app/admin/site_settings.rb
  deleted:    app/models/site_setting.rb

  deleted:    app/admin/static_files.rb
  deleted:    app/models/static_file.rb
  deleted:    app/uploaders/static_file_uploader.rb

  modified:   config/locales/ru.yml
