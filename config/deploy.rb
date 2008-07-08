require 'erb'

set :user, 'mauricio'
set :runner, 'mauricio'
set :password, 'gphwty'
set :domain, "reeds.dyndns.ws"

set :application, "reeds"
set :deploy_to, "/var/www/apps/#{application}"
set :public_directory, "#{deploy_to}/current/public"

default_run_options[:pty] = true
set :repository,  "ssh://mauricio@weddid.com/var/git/reeds"
set :scm, "git"
set :scm_passphrase, "mauricio" #This is your custom users password
set :branch, :master

set :mongrel, "/etc/init.d/mongrel_cluster"

#set :use_sudo, true

# set :gems_for_project, %w(dr_nic_magic_models swiftiply) # list of gems to be
# installed

# Update these if you're not running everything on one host.
role :app, domain
role :web, domain
role :db,  domain, :primary => true


# If you aren't deploying to /var/www/apps/#{application} on the target servers
# (which is the deprec default), you can specify the actual location via the
# :deploy_to variable: set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify your SCM
# below: set :scm, :subversion

task :stop_mongrels do
  sudo "#{mongrel} stop"
end

task :start_mongrels do
  sudo "#{mongrel} start"
end

task :restart_mongrels do
  sudo "#{mongrel} restart"
end

task :copy_mongrel_config do
  put IO.read( 'config/mongrel/cluster.yml' ), "#{shared_path}/#{application}_mongrel.yml"
  sudo "cp #{shared_path}/#{application}_mongrel.yml /etc/mongrel_cluster/#{application}_mongrel.yml"
end

task :copy_apache_config do
  template = File.read("config/apache/apache-vhost.erb")
  buffer = ERB.new(template).result(binding)
  put buffer, "#{shared_path}/#{application}_apache.conf"
  sudo "cp #{shared_path}/#{application}_apache.conf /etc/apache2/sites-available/#{application}"
  restart_apache
end

task :create_basic_dirs do
  sudo "chown -R mauricio:www-data #{deploy_to}"
  run "mkdir #{shared_path}/mongrel"
  run "mkdir #{shared_path}/apache"
end

task :copy_configs do
  copy_apache_config
  copy_mongrel_config
end

task :restart_apache do
  sudo 'apache2ctl restart'
end

namespace :deploy do
  task :start do
    start_mongrels
  end
  task :stop do
    stop_mongrels
  end  
  task :restart do
    restart_mongrels
  end  
end

after :deploy, 'deploy:cleanup'
after :deploy, :restart_mongrels
after 'deploy:setup', :create_basic_dirs
after 'deploy:setup', :copy_configs