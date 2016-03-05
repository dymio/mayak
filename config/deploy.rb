require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/whenever'
# require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
# require 'mina/rvm'    # for rvm support. (http://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

# Multistaging deploy ( `mina deploy to=production` ):
case ENV['to']
when 'production'
  set :domain, 'demo.mayak.io'
  set :user, 'dymio'
  set :deploy_to, '/var/www/mayak'
else
  # default settings (staging)
  set :domain, 'mayak.dymio.net'
  set :user, 'dymio'
  set :deploy_to, '/home/dymio/www/mayak'
  # set :rails_env, 'staging' # use it when you adding new environment
end

set :repository, 'git@github.com:dymio/mayak.git'
set :branch, 'master'
set :forward_agent, true # SSH forward_agent.
# ! probably you will need add RSA key of repository server manually once before deploy
# ! just enter your server with `ssh user@server -A` and clone your repo to any folder

# For system-wide RVM install.
#   set :rvm_path, '/usr/local/rvm/bin/rvm'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'log', 'public/assets', 'public/uploads', 'public/content']

# Optional settings:
#   set :port, '30000'     # SSH port number.

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  # invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use[ruby-2.2.3@mayak]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/public/uploads"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/public/assets"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/public/content"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/public"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/public/uploads"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/public/assets"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/public/content"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml'."]

  if repository
    repo_host = repository.split(%r{@|://}).last.split(%r{:|\/}).first
    repo_port = /:([0-9]+)/.match(repository) && /:([0-9]+)/.match(repository)[1] || '22'

    queue %[
      if ! ssh-keygen -H  -F #{repo_host} &>/dev/null; then
        ssh-keyscan -t rsa -p #{repo_port} -H #{repo_host} >> ~/.ssh/known_hosts
      fi
    ]
  end
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  to :before_hook do
    # Put things to run locally before ssh
  end
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      queue "mkdir -p #{deploy_to}/#{current_path}/tmp/"
      queue "touch #{deploy_to}/#{current_path}/tmp/restart.txt"
      invoke :'whenever:update'
    end
  end
end

namespace :rails do
  desc "Seed database"
  task :db_seed do
    queue %{
      echo "-----> Seed database for #{domain}_#{rails_env}"
      #{echo_cmd %[cd #{deploy_to!}/#{current_path!} ; RAILS_ENV="#{rails_env}" #{bundle_bin} exec rake db:seed]}
      echo "-----> Done."
    }
  end
end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers
