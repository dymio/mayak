Mayak Rails Website Template
============================

Mayak - is simple Rails application made for fast start of a common web-project.
I called it 'site template' because rails 'application templates'
[already exist](http://guides.rubyonrails.org/rails_application_templates.html).
Website template gives you major components of (almost) any website:

* admin panel
* settings
* arbitrary files upload
* pages managment
* seo parameters system
* navigation items
* news
* feedback form

[Mayak.io](http://mayak.io/) — project's website.


Software and coventions
-----------------------

Template based on Ruby 2.2.3 and use many brilliant ruby gems (check full list
and versions in Gemfile):

* [Ruby on Rails](http://rubyonrails.org/)
* [ActiveAdmin](http://activeadmin.info/) for admin panel
* [CarrierWave](https://github.com/carrierwaveuploader/carrierwave) for uploads
* [Kaminari](https://github.com/amatsuda/kaminari) for pagination
* [Autoprefixer](https://github.com/postcss/autoprefixer) for easy css
* [Mina](http://nadarei.co/mina/) for deploy

Also we use:

* [normalize.css](http://necolas.github.io/normalize.css/)
* [Dymio's HTML CSS template](https://github.com/dymio/html-css-template)
* [Chosen](http://harvesthq.github.io/chosen/)

And we respect [humans.txt](http://humanstxt.org/) convention.


Installation
------------

1. Get copy of code of this project (without git history).

2. Make sure that you have Ruby version installed, specified
    in `.ruby-version` file.

3. If you're using RVM, add '.ruby-gemset' file to the root of the application.
    [More info](https://rvm.io/workflow/projects#project-file-ruby-version).

4. In the `config/application.rb` file:

    * replace module name from 'Mayak' to your project name;

    * set your timezone and default_locale;

5. Replace all secret keys in file `config/secrets.rb`.
    You can use `bin/rake secret` for keys generation
    or [some web-generators](http://www.andrewscompanies.com/tools/wep.asp).
    You can use `secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>` for production
    if you need to hide production key from repo, but do not forget setup this
    ENV variable on server.

6. Create file `config/database.yml` for database connection.
    There is `config/database_example.yml` for example.

7. Create file `config/application.yml` for app configuration management with
    Figaro gem. There is `config/application_example.yml` for example.

8. Change `default-host` setting in the file `config/sitemap.rb`
    (and do not forget about sitemap during development).

9. Setting up the mailer in `config/environments/production.rb` file,
    if you need to sending emails from site.

10. In the file `config/initializers/active_admin.rb`
    replace `config.site_title` with title of your site.

11. In the file `config/initializers/devise.rb`
    replace value of `config.mailer_sender`.

12. In the file `config/initializers/session_store.rb` replace
    session key `_mayak_session` with your project key.

13. In the migration file of site settings
    (`db/migrate/20170307000002_create_settings.rb`) you can change default
    settings values and add new settings. TODO

14. In the seeds file (`db/seeds.rb`) you can change email and password
    of admin user. By default it admin@example.com with password 'password'.

15. Check file `app/assets/browserslist` file and set
    [settings](https://github.com/ai/browserslist#queries) you need
    for Autoprefixer.

16. Replace or remove LICENSE and UPDATE.md files.

17. When done, run:

    ```
    $ bin/bundle install --without production
    $ bin/rake db:create db:migrate
    ```

Demo data you can install with command: `bin/rake db:seed`

Else you want to remove demo data you need to: TODO.

Do not forget to change `public/favicon.ico` and all icons
in directory `public/ico/`, fill `public/humans.txt` with correct data
and uncomment correct lines in `public/robots.txt` before publishing.

Your application ready for use.
You can launch webserver with command `bin/rails server` and see a home page
at [http://localhost:3000](http://localhost:3000/) url.

And, when you finish installation, replace content of this file with description
about your project and other usefull information.
Example:

    Your project name
    =================

    Short project description here.

    Production url is [example.com](http://example.com/).

    This is Ruby on Rails project,
    based on [Mayak Rails website template](http://mayak.io/).


    Getting Started
    ---------------

    Make sure you have Ruby version installed, specified in the `.ruby-version`
    file in the root directory of the application.

    If you use [RVM](https://rvm.io/) add a '.ruby-gemset'
    [file](https://rvm.io/workflow/projects#project-file-ruby-version)
    to the root directory of the application.

    You will need [ImageMagick](https://www.imagemagick.org/) installed.

    The application uses PostgreSQL. Versions 8.2 and up are supported.
    Create database and config file `config/database.yml` for connection.
    File example:

        development:
          adapter: postgresql
          database: database_name
          pool: 5

    There is `config/database_example.yml` file for full example.

    When done, run:

        $ bin/bundle install --without production
        $ bin/rake db:create db:migrate

    Install demo data using command: `bin/rake db:seed` if you need.

    Application ready for start. You can launch webserver with
    command `bin/rails server` and see home page
    at [localhost:3000](http://localhost:3000/) url.


    Deploy
    ------

    Run deploy with command `mina deploy` or `mina production deploy`
    for production instance.


License
-------
Mayak Rails Website Template is released under the [MIT License](LICENSE).


Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Feel free to use code of the project as you want,
[create issues](https://github.com/dymio/mayak/issues) or make pull requests.
