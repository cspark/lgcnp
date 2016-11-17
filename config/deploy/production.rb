# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.


set :stage, :production
set :deploy_to, "/home/rails/lgcare"

server 'rails@lgcare.mintshop.com', port: 10022, roles: %w{web app db}

set :branch, 'master'
set :rails_env, 'production'
set :unicorn_rack_env, "production"
set :unicorn_pid, '/home/rails/lgcare/shared/pids/unicorn.pid'
set :unicorn_config_path, '/home/rails/lgcare/current/config/unicorn/production.rb'
set :unicorn_restart_sleep_time, 5

#
# set :sidekiq_queue, [
#    'please_push_notification',
#    'default'
# ]
#
# # :sidekiq_default_hooks =>  true
# set :sidekiq_pid, File.join(shared_path, 'pids', 'sidekiq.pid')
# :sidekiq_env =>  fetch(:rack_env, fetch(:rails_env, fetch(:stage)))
# :sidekiq_log =>  File.join(shared_path, 'log', 'sidekiq.log')
# :sidekiq_options =>  nil
# :sidekiq_require => nil
# :sidekiq_tag => nil
# :sidekiq_config => nil
# :sidekiq_queue => nil
# :sidekiq_timeout =>  10
# :sidekiq_role =>  :app
# :sidekiq_processes =>  1
# :sidekiq_concurrency => nil

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.


# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# And/or per server (overrides global)
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
