root = "/var/www/marketplaceapp/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"
worker_processes 4
timeout 30
preload_app true
listen '/tmp/marketplaceapp.sock', backlog: 64
listen '127.0.0.1:3030'
