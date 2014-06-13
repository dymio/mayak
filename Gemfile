source 'https://rubygems.org'
ruby '1.9.3' # Heroku specifying version

gem 'rails', '3.2.17'

# Pg is the Ruby interface to the PostgreSQL RDBMS
gem 'pg', '~> 0.17.0'

# A thin and fast web server
gem 'thin', '~> 1.6.2'

# Template language, replacing html/erb
gem 'slim', '~> 2.0.2' # 1.3.9

# The administration framework for Ruby on Rails
gem 'activeadmin', '~> 0.6.3'

# Allows simple search forms to be created against an AR3
gem 'meta_search', '~> 1.1.3'

# Files uploader
gem 'carrierwave', '~> 0.10.0'

# Manipulate images with minimal use of memory via ImageMagick
gem 'mini_magick', '~> 3.7.0'

# The Ruby cloud services library
# gem 'fog', '~> 1.22.0'

# Russian language support for Ruby and Rails
gem 'russian', '~> 0.6.0'

# Paginator
gem 'kaminari', '~> 0.15.1'

# Breadcrumbs
gem 'breadcrumbs_on_rails', '~> 2.3.0'

# Organise ActiveRecord model into a tree structure
gem 'ancestry', '~> 2.1.0'

# XML Sitemap generator
gem 'sitemap_generator', '~> 5.0.4'

# Clean ruby syntax for writing and deploying cron jobs
# gem 'whenever', '~> 0.9.2'

# Forms builder
# gem 'simple_form', '~> 3.0.2'

# Flexible authentication solution for Rails with Warden
# gem 'devise', '~> 3.2.4'

# Helper for building html class attribute
gem 'css-class-string'

# Email validator
# gem 'email_validator'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.6'
  gem 'coffee-rails', '~> 3.2.2'

  # Parse css (sass too) and vendor prefixes to css rules
  gem 'autoprefixer-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

# using old version of jquery-rails for Active Admin correct work
# TODO update when update from active_admin 0.6.3
gem 'jquery-rails', '~>2.3'

group :development do
  # When mail is sent from your application, Letter Opener will open a preview
  gem 'letter_opener', '~>1.2'
  
  # Fix some bugs on Linux of Rails work (make rails console works as example)
  # gem 'rb-readline'

  # Quiet assets turn off rails assets log
  gem 'quiet_assets'
end

# Deploy with Capistrano
gem 'capistrano', '~>2.15'
gem 'capistrano-ext'
gem 'capistrano_colors'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# To use debugger
# gem 'debugger'
