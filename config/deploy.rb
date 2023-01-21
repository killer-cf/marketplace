lock "~> 3.17.1"

set :application, "marketplaceapp"
set :repo_url, "https://github.com/killer-cf/marketplace.git"
set :rvm_custom_path, "/usr/share/rvm"
set :branch, 'capistrano-deploy'
set :deploy_to, "/var/www/marketplaceapp"
set :format, :airbrussh
set :log_level, :debug
set :user, 'deploy'
set :keep_releases, 5

set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :puma_bind,       "unix:///tmp/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log,  "#{release_path}/log/puma.error.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

append :linked_files, "config/database.yml", 'config/master.key'
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"
