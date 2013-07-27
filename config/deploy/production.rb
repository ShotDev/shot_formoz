set :deploy_to, "/home/rails/shot_formoz_production"
server "54.251.122.231", :app, :web, :db, :primary => true
set :branch, :master

namespace :deploy do
  desc "Create database.yml in config"
  task :update_db_config do
    db_config = "#{shared_path}/config/database.yml.production"
    run "ln #{db_config} #{release_path}/config/database.yml"
  end

  desc "Link local settings to config/local_settings.yml"
  task :update_local_settings do
    local_settings = "#{shared_path}/config/local_settings.yml.production"
    run "ln #{local_settings} #{release_path}/config/local_settings.yml"
  end
end

after "deploy:finalize_update", "deploy:update_db_config"
after "deploy:finalize_update", "deploy:update_local_settings"
