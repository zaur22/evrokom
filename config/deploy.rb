lock '3.2.1'

set :username, 'evrokom'
set :application, 'Evrokom'
set :deploy_to, "/home/#{fetch(:username)}/#{fetch(:application)}"

set :scm, :git
set :repo_url, 'git@github.com:zaur22/evrokom.git'
set :deploy_via, :remote_cache
set :branch, 'master'

set :unicorn_config, "#{shared_path}/config/unicorn.rb"
set :unicorn_pid, "#{shared_path}/run/unicorn.pid"
set :rails_env, 'production'

set :linked_files, %w{config/secrets.yml config/database.yml}
set :linked_dirs, %w{public/upload}

set :format, :pretty

set :pty, false

set :log_level, :info

namespace :deploy do
  after :finishing, 'application:stop'
  after :finishing, 'application:start'
  after :finishing, :cleanup
end
