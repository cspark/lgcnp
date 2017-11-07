worker_processes 6
APP_PATH = "/home/janustabuser/lgcare/"
working_directory APP_PATH + "current/"

preload_app true

timeout 600
# rails_env = 'production'

# This is where we specify the socket.
# We will point the upstream Nginx module to this socket later on
listen APP_PATH+"shared/sockets/unicorn.sock", :backlog => 64
pid APP_PATH+"shared/pids/unicorn.pid"

# Set the path of the log files inside the log folder of the testapp
stderr_path APP_PATH+"current/log/unicorn.stderr.log"
stdout_path APP_PATH+"current/log/unicorn.stdout.log"

before_fork do |server, worker|
# This option works in together with preload_app true setting
# What is does is prevent the master process from holding
# the database connection
  defined?(ApplicationRecord) and
    ApplicationRecord.connection.disconnect!
end

after_fork do |server, worker|
# Here we are establishing the connection after forking worker
# processes
  defined?(ApplicationRecord) and
    ApplicationRecord.establish_connection
end
