# config valid only for current version of Capistrano
lock '3.5.0'

set :rails_env, 'production'
set :unicorn_env, 'production'
set :application, 'qops'
# set :repo_url, 'git@github.com:devtempus/qops.git'
set :repo_url, 'https://github.com/devtempus/qops.git'
set :domain, 'gds-deploy@95.46.98.193'
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
ask :branch, 'for-deploy'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/#{fetch(:application)}"

# Default value for :scm is :git
set :scm, :git

# Ruby settings
set :rvm_ruby_version, '2.3.1'
set :rvm_type, :user
set :rvm_path, '~/.rvm'

# Unicorn
# set :unicorn_conf, "#{deploy_to}/releases/current/config/unicorn.rb"
# set :unicorn_pid, "#{deploy_to}/shared/tmp/pids/unicorn.pid"

set :use_sudo, false

# Default value for :format is :airbrussh.
# set :format, :airbrussh
set :format, :pretty

set :passenger_restart_with_touch, true

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_files, %w{config/database.yml config/secrets.yml}

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

SSHKit.config.command_map[:rake] = "#{fetch(:rvm_path)}/bin/rvm ruby-#{fetch(:rvm_ruby_version)} do bundle exec rake"
# SSHKit.config.command_map[:unicorn] = "#{fetch(:rvm_path)}/bin/rvm ruby-#{fetch(:rvm_ruby_version)} do bundle exec unicorn"


# namespace :deploy do
#
#   after :restart, :clear_cache do
#     on roles(:web), in: :groups, limit: 3, wait: 10 do
#       # Here we can do anything such as:
#       # within release_path do
#       #   execute :rake, 'cache:clear'
#       # end
#     end
#   end
#
# end


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  desc 'Upload database.yml & secret.yml'
  task :upload do
    on roles(:all) do
      execute "mkdir -p #{deploy_to}/shared/config"
      upload!('config/database.yml.example', "#{deploy_to}/shared/config/database.yml")
      upload!('config/secrets.yml.example', "#{deploy_to}/shared/config/secrets.yml")
    end
  end

  # desc 'Create DB'
  # task :create_db do
  #   on roles(:all) do
  #     execute "cd #{deploy_to}/current && RAILS_ENV=#{fetch(:rails_env)} #{fetch(:rvm_path)}/bin/rvm ruby-#{fetch(:rvm_ruby_version)} do bundle exec rake db:create"
  #   end
  # end

  desc 'Runs rake db:create'
  task create_db: [:set_rails_env] do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:create RAILS_ENV=#{fetch(:rails_env)}"
        end
      end
    end
  end

end

# namespace :unicorn do
#   task :restart do
#     on roles(:all) do
#       unicorn_exec = "#{fetch(:rvm_path)}/bin/rvm ruby-#{fetch(:rvm_ruby_version)} do bundle exec unicorn"
#       execute "if [ -f #{fetch(:unicorn_pid)} ] && [ -e /proc/$(cat #{fetch(:unicorn_pid)}) ]; then kill -USR2 `cat #{fetch(:unicorn_pid)}`; else cd #{deploy_to}/current && #{unicorn_exec} -c #{fetch(:unicorn_conf)} -E #{fetch(:rails_env)} -D; fi"
#     end
#   end
#
#   task :start do
#     on roles(:all) do
#       unicorn_exec = "#{fetch(:rvm_path)}/bin/rvm ruby-#{fetch(:rvm_ruby_version)} do bundle exec unicorn"
#       execute "cd #{deploy_to}/current && #{unicorn_exec} -c #{fetch(:unicorn_conf)} -E #{fetch(:rails_env)} -D"
#     end
#   end
#
#   task :stop do
#     on roles(:all) do
#       execute "if [ -f #{fetch(:unicorn_pid)} ] && [ -e /proc/$(cat #{fetch(:unicorn_pid)}) ]; then kill -QUIT `cat #{fetch(:unicorn_pid)}`; fi"
#     end
#   end
# end


after 'deploy:finishing', 'deploy:cleanup'
# after 'deploy:finished', 'unicorn:restart'
before 'deploy:migrate', 'deploy:create_db'
before 'deploy:check:linked_files', 'deploy:upload'
