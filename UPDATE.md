Updating process
================

* In the outer directory install latest rails, using latest ruby:

    ```
    $ rvm use ruby-2.1.2
    $ rvm gemset delete mayak
    $ rvm install ruby-2.1.5
    $ rvm --default use ruby-2.1.5
    $ rvm gemset create mayak
    $ rvm gemset use mayak
    $ gem install --no-rdoc --no-ri rails -v 4.1.8
    $ rails new mayak --skip-bundle --skip-test-unit --database=postgresql
    $ mv mayak rails_4.1.8
    ```

* Save this directory until next update unchanged - any chages do with a copy

* Generate scaffold for test in the new directory:

    ```
    $ bin/bundle install
    $ bin/rails generate scaffold Article author:references{polymorphic} title:string slug:string:index published_at:datetime:index image:string intro:text body:text seodata:text hided:boolean:index
    $ bin/rake db:migrate
    ```

* Save scaffolded version for future

* Diff with previous scaffolded rails and analyse changes for update current version of Mayak

* Copy new rails files (without scaffold) to mayaknew folder

* Merge 'Gemfile' from old Mayak with updating versions of gems

* Run `bin/bundle install` and generate all configs:

    ```
    bin/rails g active_admin:install
    bin/rails g kaminari:config
    bin/rake sitemap:install
    bin/bundle exec wheneverize .
    bin/bundle exec mina init
    ```

* Carefully merge Mayak to new instance

* Remove old Mayak files except '.git' directory

* Move all new Mayak files to old directory with '.git' inside

* Run `bin/rake db:drop db:create db:migrate db:seed`

* Check all changes using `git diff` : we need to be sure that we didn't lost anything

* Run `bin/rails server` and check result manually

* `git add . && git commit -m "Update to Ruby 2.1.5 and Rails 4.1.8" && git push` - Le Roi est mort, vive le Roi!
