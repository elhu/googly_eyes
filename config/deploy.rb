set :application, 'googly-eyes'
set :repository,  'git@github.com:elhu/googly_eyes.git'

role :web, "elhu.me"
role :app, "elhu.me"
role :db, "elhu.me"

set :user, 'app'
set :use_sudo, false

set(:deploy_to) { "/home/app/#{application}" }

set :normalize_asset_timestamps, false
set :ruby_path, "/home/app/.rbenv/shims/ruby"
set :bundle_cmd, "PATH=/home/app/.rbenv/shims/:$PATH bundle"
set :whenever_command, "#{bundle_cmd} exec whenever"

after "deploy:restart", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

task :symlink_config do
  run "ln -s #{shared_path}/config/*.yml #{current_path}/config/"
end

after 'deploy:create_symlink' do
  symlink_config
end

after 'deploy:create_symlink' do
  run "ln -nfs #{shared_path}/public/eyesoup #{current_path}/public/eyesoup"
end

require 'bundler/capistrano'
require 'whenever/capistrano'
