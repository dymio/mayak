# -*- encoding : utf-8 -*-
Encoding.default_internal = 'utf-8'
Encoding.default_external = 'utf-8'

ENV['LANG']=    'ru_RU.UTF-8'
ENV['LC_ALL']=  'ru_RU.UTF-8'

require 'bundler/capistrano'
require 'capistrano_colors'

set :application,       'mayak'

set :ip_address,        '195.208.47.203'
set :user,              'mayakuser'
set :group,             'mayakuser'

set :wwwuser,           'www-data'
set :wwwgroup,          'www-data'

set :repository,        'git@github.com:dymio/mayak.git'
set :scm,               :git
set :branch,            'master'
set :scm_username,      'git'
set :scm_verbose,        true
set :deploy_via,         :remote_cache
set :keep_releases,      3

set :deploy_to,          "/home/#{user}/www/#{application}"
set :shared_directory,   "#{deploy_to}/shared"
set :use_sudo,           false
set :ssh_options,        { :forward_agent => true }
default_run_options[:pty] = true

role :app,               ip_address
role :web,               ip_address
role :db,                ip_address, primary: true

set :rails_env,         'production'

after 'deploy:update_code', :roles => [:web, :db, :app] do
  run "chmod 777 #{release_path}/public"
  run "chmod 777 #{release_path}/log"
  run "ln -s #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  run "touch #{release_path}/tmp/restart.txt"
end

# after "deploy", "refresh_sitemap"
# task :refresh_sitemap do
#   run "cd #{release_path} && RAILS_ENV=#{rails_env} bundle exec rake sitemap:refresh:no_ping"
# end

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
