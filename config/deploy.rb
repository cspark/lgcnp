# config valid only for current version of Capistrano
lock '3.8.0'

set :application, 'lgcare'
set :repo_url, 'https://github.com/ShakeJ/LGCNP.git'
# set :repo_tree, 'server/cnp'
set :default_env, {
  'LD_LIBRARY_PATH' => "/usr/lib/oracle/11.2/client64/lib/"
}
# set :rbenv_ruby, '2.2.3'
set :rbenv_ruby, '2.3.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
# set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value
# set :linked_dirs, %w{log}
set :linked_files, %w{public/TEST public/uploads/TEST}
set :linked_files, %w{public/BEAU public/uploads/BEAU}
set :linked_files, %w{public/CNP public/uploads/CNP}
set :linked_files, %w{public/CLAB public/uploads/CLAB}
set :linked_files, %w{public/CNPR public/uploads/CNPR}
set :linked_files, %w{public/RLAB public/uploads/RLAB}
set :linked_files, %w{public/LABO public/uploads/LABO}
set :linked_files, %w{public/MART public/uploads/MART}
set :linked_files, %w{public/TMR public/uploads/TMR}
set :linked_files, %w{public/ONEP public/uploads/ONEP}

# set :linked_dirs, fetch(:linked_dirs, []).push('public', 'log', 'public')
# set :linked_dirs, fetch(:linked_dirs, []).push('public/TEST', 'log', 'public/TEST')
# set :linked_dirs, fetch(:linked_dirs, []).push('public/BEAU', 'log', 'public/uploads/BEAU')
# set :linked_dirs, fetch(:linked_dirs, []).push('public/CNP', 'log', 'public/uploads/CNP')
# set :linked_dirs, fetch(:linked_dirs, []).push('public/CLAB', 'log', 'public/uploads/CLAB')
# set :linked_dirs, fetch(:linked_dirs, []).push('public/CNPR', 'log', 'public/uploads/CNPR')
# set :linked_dirs, fetch(:linked_dirs, []).push('public/RLAB', 'log', 'public/uploads/RLAB')
# set :linked_dirs, fetch(:linked_dirs, []).push('public/LABO', 'log', 'public/uploads/LABO')
# set :linked_dirs, fetch(:linked_dirs, []).push('public/MART', 'log', 'public/uploads/MART')
# set :linked_dirs, fetch(:linked_dirs, []).push('public/TMR', 'log', 'public/uploads/TMR')
# set :linked_dirs, fetch(:linked_dirs, []).push('public/ONEP', 'log', 'public/uploads/ONEP')

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

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:legacy_restart'
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
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
