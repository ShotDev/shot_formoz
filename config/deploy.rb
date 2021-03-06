require "rvm/capistrano"
require "bundler/capistrano"
require "capistrano/ext/multistage"
# uncomment this if you wanna pre-compile assets when deploying
# load 'deploy/assets'

set :stages, %w(production development)
set :default_stage, "development"

set :application, "shot_formoz"
set :repository,  "https://github.com/ShotDev/shot_formoz.git"
set :rails_env, "production" #added for delayed job  

set :scm, :git 
set :user, "rails"
set :use_sudo,false
default_run_options[:pty] = true

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

desc "run rspec"
namespace :deploy do
  task :rspec do
    run "cd #{current_path} && RAILS_ENV=production bundle exec rake db:test:prepare"
    run "cd #{current_path} && bundle exec rspec spec/"
  end
end
