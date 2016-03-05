Mayak Rails Website Template
============================

Mayak - is simple Rails application made for fast start of a common web-project. I call it 'site template' because rails [application templates](http://guides.rubyonrails.org/rails_application_templates.html) already exists. Website template gives you major components of (almost) any website:

* admin panel;
* settings;
* arbitrary files upload;
* pages managment;
* seo parameters system;
* navigation items;
* news;
* feedback form;


Software and coventions
-----------------------

Template based on Ruby 2.2.3 and use many brilliant ruby gems (check full list and versions in Gemfile):

* [Ruby on Rails](http://rubyonrails.org/);
* [ActiveAdmin](http://activeadmin.info/) for admin panel;
* [CarrierWave](https://github.com/carrierwaveuploader/carrierwave) for files upload;
* [Kaminari](https://github.com/amatsuda/kaminari) for pagination;
* [Autoprefixer](https://github.com/postcss/autoprefixer) for easy css;
* [Mina](http://nadarei.co/mina/) for deploy;

Also we use:

* [normalize.css](http://necolas.github.io/normalize.css/)
* [Dymio's HTML CSS template](https://github.com/dymio/html-css-template)
* [Chosen](http://harvesthq.github.io/chosen/)

And we respect [humans.txt](http://humanstxt.org/) convention.


Installation
------------

1. Get copy of code of this project (without git history).

2. Make sure that you have Ruby version installed, specified in `.ruby-version` and `Gemfile` files.

3. If you use RVM, add [.ruby-gemset file](http://stackoverflow.com/questions/15708916/use-rvmrc-or-ruby-version-file-to-set-a-project-gemset-with-rvm) to the root of the application.

4. Replace module name in `config/application.rb` file from 'Mayak' to your project name.

5. Set your timezone and default_locale in `config/application.rb` file.

6. Replace all secret keys in file `config/secrets.rb`. You can use `bin/rake secret` or [some generators](http://www.andrewscompanies.com/tools/wep.asp) for generate it. You can use `secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>` for production if you need to hide production key from repo, but do not forget setup this ENV variable on server.

7. Create file `config/database.yml` for database connection. There is `config/database_example.yml` for example.

8. Change `default-host` setting in the file `config/sitemap.rb` (and do not forget about sitemap during development).

9. Setting up the mailer in `config/environments/production.rb` file, if you need to sending emails from site.

10. In the file `config/initializers/active_admin.rb` replace `config.site_title` with title of your site.

11. In the file `config/initializers/devise.rb` replace value of `config.mailer_sender`.

12. In the file `config/initializers/session_store.rb` replace session key `_mayak_session` with your project key.

13. TODO : In the migration file of site settings (`db/migrate/20140405000000_create_site_settings.rb`) you can change default settings values and add new settings.

14. In the first migration file (`db/migrate/20140911000000_devise_create_admin_users.rb`) you can change email and password of admin user. By default it admin@example.com with password 'password'.

15. Check file `app/assets/browserslist` and set [settings](https://github.com/ai/browserslist#queries) you need for Autoprefixer.

16. Replace or remove LICENSE.txt and UPDATE.md files.

17. When done, run:

    ```
    $ bin/bundle install --without production
    $ bin/rake db:create db:migrate
    ```

Demo data you can install with command: `bin/rake db:seed`

Else you want to remove demo data you need to: TODO.

Do not forget to change `public/favicon.ico` and all icons in directory `public/ico/`, fill `public/humans.txt` with correct data and uncomment correct lines in `public/robots.txt` before publish.

Your app ready for use. You can launch webserver with command `bin/rails server` and see home page at [localhost:3000](http://localhost:3000/) url.

And, when you finish installation, replace content of this file with description about your project and other usefull information.
As example:

    Your project name
    =================

    Short project description here.
    Production url is [example.com](http://example.com).

    Project based on [Mayak Rails website template](http://mayak.io).

    Getting Started
    ---------------

    You can find required version of Ruby in file `.ruby-version` in the root directory of the application.

    If you use RVM, add [.ruby-gemset file](http://stackoverflow.com/questions/15708916/use-rvmrc-or-ruby-version-file-to-set-a-project-gemset-with-rvm) to the root directory of the application.

    Create file `config/database.yml` for database connection with content like:

        development:
          adapter: postgresql
          database: project_name
          pool: 5

    There is `config/database_example.yml` for full example.

    When done, run:

        $ bin/bundle install --without production
        $ bin/rake db:create db:migrate

    You can install demo data using command: `bin/rake db:seed`

    Application ready for start. You can launch webserver with command `bin/rails server` and see home page at [localhost:3000](http://localhost:3000/) url.


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


Feel free to use code of the project as you want, [create issues](https://github.com/dymio/mayak/issues) or make pull requests.




TODO list
---------

- Try to use Nested Set instead Ancestry for Pages

- differences from prev almost-major version
  - modified:   db/migrate/20140404000000_create_content_pages.rb
  - modified:   app/models/content_page.rb
  - modified:   app/controllers/content_pages_controller.rb
  - modified:   app/admin/content_pages.rb
  - modified:   app/views/content_pages/show.html.slim
  - deleted:    app/assets/images/admin/content_page_types.png
  - deleted:    app/helpers/content_pages_helper.rb
  - deleted:    app/models/active_admin/views/index_as_ancestry_roots_block.rb
  - deleted:    app/views/admin/content_pages/_index_line.html.slim
  - deleted:    app/views/content_pages/_sidenav_level.html.slim

- put all russian text to I18n locale files

- Contacts page with feedback

- логирование изменений материалов пользователями ?

- make demo

- Store default SiteSettings in yaml and add they to db when load automatically

- группы для настроек сайта

- Store default Pages in yaml and add they to db when load automatically

- create tests

- replace Redactor

- add social links setting and view helper
