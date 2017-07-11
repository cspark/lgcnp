# config valid only for current version of Capistrano
lock '3.8.0'

set :application, 'lgcare'
set :repo_url, 'git@gitlab.mintech.kr:cnp/lgcare-cnp-server.git'
# set :repo_tree, 'server/cnp'
set :default_env, {
  'LD_LIBRARY_PATH' => "/usr/lib/oracle/11.2/client64/lib/"
}
# set :rbenv_ruby, '2.2.3'
set :rbenv_ruby, '2.3.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
# set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value
set :linked_dirs, %w{log}

# set :linked_dirs, fetch(:linked_dirs, []).push('log')
# set :linked_dirs, fetch(:linked_dirs, []).push('public/BEAU')
# set :linked_dirs, fetch(:linked_dirs, []).push('public/CNP')
# set :linked_dirs, fetch(:linked_dirs, []).push('public/CLAB')
# set :linked_dirs, fetch(:linked_dirs, []).push('public/CNPR')
# set :linked_dirs, fetch(:linked_dirs, []).push('public/RLAB')
# set :linked_dirs, fetch(:linked_dirs, []).push('public/LABO')
# set :linked_dirs, fetch(:linked_dirs, []).push('public/MART')
# set :linked_dirs, fetch(:linked_dirs, []).push('public/TMR')
# set :linked_dirs, fetch(:linked_dirs, []).push('public/ONEP')
# set :linked_dirs, fetch(:linked_dirs, []).push('public/TEST')

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
# set :deploy_to, '/var/www/my_app'
set :scm, :git
# set :format, :pretty
# set :log_level, :debug
set :pty, false
set :port, 10022
# set :linked_files, %w{config/database.yml}
# set :linked_files, %w{config/database.yml config/secrets.yml}
# set :linked_dirs, fetch(:linked_dirs, []).push('public/system', 'log', 'public/uploads')

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 1
set :current_path, "/home/janustabuser/lgcare/current/"
set :shared_path, "/home/janustabuser/lgcare/shared/"

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:legacy_restart'
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      execute "rm -rf #{current_path}/public/TEST"
      execute "rm -rf #{shared_path}/public/uploads/TEST"
      execute "mkdir #{shared_path}/public/uploads/TEST"
      execute "ln -s #{shared_path}/public/uploads/TEST #{current_path}/public/"

      execute "rm -rf #{current_path}/public/BEAU"
      execute "rm -rf #{shared_path}/public/uploads/BEAU"
      execute "mkdir #{shared_path}/public/uploads/BEAU"
      execute "ln -s #{shared_path}/public/uploads/BEAU #{current_path}/public/"

      execute "rm -rf #{current_path}/public/CNP"
      execute "rm -rf #{shared_path}/public/uploads/CNP"
      execute "mkdir #{shared_path}/public/uploads/CNP"
      execute "ln -s #{shared_path}/public/uploads/CNP #{current_path}/public/"

      execute "rm -rf #{current_path}/public/CLAB"
      execute "rm -rf #{shared_path}/public/uploads/CLAB"
      execute "mkdir #{shared_path}/public/uploads/CLAB"
      execute "ln -s #{shared_path}/public/uploads/CLAB #{current_path}/public/"

      execute "rm -rf #{current_path}/public/CNPR"
      execute "rm -rf #{shared_path}/public/uploads/CNPR"
      execute "mkdir #{shared_path}/public/uploads/CNPR"
      execute "ln -s #{shared_path}/public/uploads/CNPR #{current_path}/public/"

      execute "rm -rf #{current_path}/public/RLAB"
      execute "rm -rf #{shared_path}/public/uploads/RLAB"
      execute "mkdir #{shared_path}/public/uploads/RLAB"
      execute "ln -s #{shared_path}/public/uploads/RLAB #{current_path}/public/"

      execute "rm -rf #{current_path}/public/LABO"
      execute "rm -rf #{shared_path}/public/uploads/LABO"
      execute "mkdir #{shared_path}/public/uploads/LABO"
      execute "ln -s #{shared_path}/public/uploads/LABO #{current_path}/public/"

      execute "rm -rf #{current_path}/public/MART"
      execute "rm -rf #{shared_path}/public/uploads/MART"
      execute "mkdir #{shared_path}/public/uploads/MART"
      execute "ln -s #{shared_path}/public/uploads/MART #{current_path}/public/"

      execute "rm -rf #{current_path}/public/TMR"
      execute "rm -rf #{shared_path}/public/uploads/TMR"
      execute "mkdir #{shared_path}/public/uploads/TMR"
      execute "ln -s #{shared_path}/public/uploads/TMR #{current_path}/public/"

      execute "rm -rf #{current_path}/public/ONEP"
      execute "rm -rf #{shared_path}/public/uploads/ONEP"
      execute "mkdir #{shared_path}/public/uploads/ONEP"
      execute "ln -s #{shared_path}/public/uploads/ONEP #{current_path}/public/"
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
end
