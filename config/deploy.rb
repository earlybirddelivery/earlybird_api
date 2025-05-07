set :repo_url,        'git@github.com:Loosers003/earlybird_api.git'
set :application,     'earlybird-api'
set :user,            'deploy'
set :puma_threads,    [4, 16]
set :puma_workers,    0

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w[~/.ssh/id_rsa.pub] }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true # Change to false when not using ActiveRecord

set :keep_releases, 5

## Linked Files & Directories (Default None):
# set :linked_files, %w{config/database.yml}
# set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end
  before :start, :make_dirs
end

namespace :deploy do
  desc 'Make sure local git is in sync with remote.'
  task :check_revision do
    on roles(:app) do
      unless %x(git rev-parse HEAD) == %x(git rev-parse origin/master)
        puts 'WARNING: HEAD is not the same as origin/master'
        puts 'Run `git push` to sync changes.'
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  task :sidekiq_restart do
    on roles(:tools) do
      execute :sudo, :systemctl, 'daemon-reload'
      execute :sudo, :systemctl, :restart, :sidekiq
    end
  end

  desc 'Runs rake db:seed'
  task seed: [:set_rails_env] do
    on fetch(:migration_servers) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end

  #   before :starting,     :check_revision
  after 'migrate', 'seed'
  after :finishing, :cleanup
  after :finishing, :sidekiq_restart
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
