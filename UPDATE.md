Updating process
================

* In the outer directory install latest rails, using latest ruby:

    ```
    $ rvm get stable
    $ rvm use ruby-prev.version
    $ rvm gemset delete mayak
    $ rvm install ruby-new.version
    $ rvm --default use ruby-new.version
    $ rvm gemset create mayak
    $ rvm gemset use mayak
    $ gem install bundler
    $ gem install --no-rdoc --no-ri rails -v rails.new.version
    $ rails new mayak --skip-bundle --skip-test-unit --database=postgresql
    $ mv mayak rails_new.version
    ```

* Save this directory until next update unchanged - any chages do with a copy

* Generate scaffold for test in the new directory:

    ```
    $ bin/bundle install
    $ bin/rails generate scaffold Author name:string
    $ bin/rails generate scaffold Article author:belongs_to source:references{polymorphic} title:string slug:string:index published_at:datetime:index image:string intro:text body:text seodata:text hided:boolean:index
    $ bin/rake db:drop db:create db:migrate
    ```

* Save scaffolded version for future

* Diff with previous scaffolded rails and analyse changes for update current version of Mayak

* Copy new rails files (without scaffold) to mayaknew folder

* Merge 'Gemfile' from old Mayak with updating versions of gems

* Run `bin/bundle install --without production` and generate all configs:

    ```
    bin/rails g active_admin:install
    bin/rails g kaminari:config
    bin/rails g uploader Avatar
    bin/rake sitemap:install
    bin/bundle exec wheneverize .
    bin/bundle exec mina init
    ```

* Carefully merge Mayak to new instance

* Remove old Mayak files except '.git' directory

* Move all new Mayak files to old directory with '.git' inside

* Run `bin/rake db:drop db:create db:migrate db:seed`

* Check all changes using `git diff` : we need to be sure that we didn't lost anything important

* Run `bin/rails server` and check result manually

* `git add . && git commit -m "Update to Ruby new.version and Rails new.version" && git push` - Le Roi est mort, vive le Roi!
