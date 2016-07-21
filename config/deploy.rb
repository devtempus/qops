# config valid only for current version of Capistrano
lock '3.5.0'

# Ruby settings
set :rvm_ruby_version, '2.3.1'
set :rvm_type, :user
set :rvm_path, '~/.rvm'

# Rails setting
set :rails_env, 'production'

set :application, 'qops'
set :repo_url, 'git@github.com:devtempus/qops.git'


# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'
set :deploy_to, "/home/deploy/qops"

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_files, %w(config/database.yml config/secrets.yml)

# Default value for linked_dirs is []
set :linked_dirs, %w(bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system)

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

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

  # task :restart do
  #   on roles(:app), in: :sequence, wait: 5 do
  #     execute :touch, release_path.join('tmp/restart.txt')
  #   end
  # end

  desc 'Restart application'
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  desc 'Upload database.yml'
  task :upload do
    on roles(:all) do
      execute "mkdir -p #{deploy_to}/shared/config"
      upload!("config/database.yml.#{fetch(:rails_env)}", "#{deploy_to}/shared/config/database.yml")
    end
  end

  task :create_db do
    on roles(:all) do
      execute "cd #{deploy_to}/current && RAILS_ENV=#{fetch(:rails_env)} #{fetch(:rvm_path)}/bin/rvm ruby-#{fetch(:rvm_ruby_version)} do bundle exec rake db:create"
    end
  end

  before 'deploy:migrate', 'deploy:create_db'
  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end
