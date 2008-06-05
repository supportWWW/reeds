
set :user, 'deploy'
set :runner, 'deploy'
set :password, 'e30o96'
set :domain, "weddid.com"

set :application, "reeds"
set :deploy_to, "var/www/apps/#{application}"

set :repository, "/var/git/reeds"  #ivor@weddid.com: - the repo is on the same machine
set :scm, "git"
set :branch, :master

set :mongrel, "/etc/init.d/mongrel_cluster"

set :use_sudo, true

# set :gems_for_project, %w(dr_nic_magic_models swiftiply) # list of gems to be installed

# Update these if you're not running everything on one host.
role :app, domain
role :web, domain
role :db,  domain, :primary => true

# If you aren't deploying to /var/www/apps/#{application} on the target
# servers (which is the deprec default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

task :restart_mongrels do
  sudo "#{mongrel} restart"
end

task :stop_mongrels do
  sudo "#{mongrel} stop"
end

task :start_mongrels do
  sudo "#{mongrel} restart"
end

task :copy_mongrel_config do
  put IO.read( 'config/mongrel/cluster.yml' ), "#{shared_path}/mongrel/#{application}_mongrel.yml"
  sudo "cp #{shared_path}/mongrel/#{application}_mongrel.yml /etc/mongrel_cluster/#{application}_mongrel.yml"
end

task :copy_nginx_config do
  put IO.read( 'config/nginx/rails_nginx_vhost.conf' ), "#{shared_path}/nginx/#{application}_nginx.conf"
  sudo "cp #{shared_path}/nginx/#{application}_nginx.conf /usr/local/nginx/conf/vhosts/#{application}.conf"
end

task :copy_configs do
  copy_nginx_config
  copy_mongrel_config
end

after :deploy, :restart_mongrels
after :setup, :copy_configs