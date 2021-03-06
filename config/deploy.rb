require 'erb'
require 'mongrel_cluster/recipes'

set :user, "reeds"
set :runner, "reeds"
set :application, "reeds"
set :domain, "reeds.webhop.net"
set :password, '00r33d5'

# Update these if you're not running everything on one host.
role :app, domain
role :web, domain, :cron => true
role :db,  domain, :primary => true
role :scm, domain # used by deprec if you want to install subversion

# If you aren't deploying to /var/www/apps/#{application} on the target
# servers (which is the deprec default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

set :port, 2222

set :deploy_to, "/u/apps/reeds" # I like this location

set :use_sudo, true

default_run_options[:pty] = true
set :repository,  "git@github.com:supportWWW/reeds.git"
set :scm, "git"
set :scm_passphrase, "w@11supp0rt" #This is your ssh key password
set :branch, "master"
set :deploy_via, :remote_cache
set :git_enable_submodules, 1

set :server_name, "reeds.webhop.net"
#set :server_alias, "gnm7rcaa.joyent.us"

#set :mongrel_config, "/etc/mongrel_cluster/mongrel_cluster.yml"

set :symlinked_public_dirs, %w(uploaded_images uploaded_files vehicles)

task :create_public_shared_dirs do
  symlinked_dirs.each do |d|
    run "mkdir -p #{shared_path}/public/#{d}"
  end
end

task :copy_mongrel_config do
  put IO.read( 'config/mongrel/cluster.yml' ), "#{shared_path}/#{application}_mongrel.yml"
  sudo "ln -sf #{shared_path}/#{application}_mongrel.yml /etc/mongrel_cluster/#{application}.yml"
end

task :copy_nginx_config do
  put IO.read( 'config/nginx/rails_nginx_vhost.conf' ), "#{shared_path}/#{application}_nginx_vhost.conf"
  sudo "ln -sf #{shared_path}/#{application}_nginx_vhost.conf /etc/nginx/sites-available/reeds"
  sudo "ln -sf /etc/nginx/sites-available/reeds /etc/nginx/sites-enabled/reeds"
  restart_nginx
end

task :copy_haproxy_config do
  put IO.read( 'config/haproxy/haproxy.cfg' ), "#{shared_path}/haproxy.cfg"
  sudo "ln -sf #{shared_path}/haproxy.cfg /etc/haproxy.cfg"
  restart_haproxy
end

task :copy_monit_configs, :roles => [:app] do
  %w(mongrel nginx postfix haproxy mysql).each do |service|
    put IO.read( "config/monit/etc/monit.d/monit_#{service}.conf" ), "#{shared_path}/monit_#{service}.conf"
    sudo "ln -sf #{shared_path}/monit_#{service}.conf /etc/monit.d/monit_#{service}.conf"
  end
  restart_monit
end

task :create_basic_dirs do
  sudo "chown -R reeds:www-data #{deploy_to}"
  create_public_shared_dirs
end

task :copy_configs do
  copy_nginx_config
  copy_mongrel_config
  copy_haproxy_config
  copy_monit_configs
end


task :chmod_public_folder do
  run "chmod -R 777 #{deploy_to}/current/public"
end

task :chmod_tmp_folder do
  run "chmod -R 777 #{deploy_to}/current/tmp"
  run "mkdir #{deploy_to}/current/tmp/attachment_fu"
  run "chmod -R 777 #{deploy_to}/current/tmp/attachment_fu"
end

# this will create the shared folder at 'cap deploy:setup'
task :after_setup, :roles => [:app, :web] do
  symlinked_public_dirs.each { |dir| run "mkdir -p #{shared_path}/public/#{dir}" }
end

#this will create the symlink after 'cap deploy'
task :after_symlink, :roles => [:app, :web] do
  symlinked_public_dirs.each { |dir| run "ln -nfs #{shared_path}/public/#{dir} #{current_path}/public/#{dir}" }
end

after "deploy:update", 'chmod_public_folder'
after "deploy:update", 'chmod_tmp_folder'
#after 'deploy:setup', 'copy_ssl_files'

namespace :deploy do
  namespace :web do
    desc <<-DESC
      Present a maintenance page to visitors. Disables your application's web \
      interface by writing a "maintenance.html" file to each web server. The \
      servers must be configured to detect the presence of this file, and if \
      it is present, always display it instead of performing the request.

      By default, the maintenance page will just say the site is down for \
      "maintenance", and will be back "shortly", but you can customize the \
      page by specifying the REASON and UNTIL environment variables:

        $ cap deploy:web:disable \\
              REASON="hardware upgrade" \\
              UNTIL="12pm Central Time"

      THIS is a customized task found in deploy.rb.
    DESC
    task :disable, :roles => :web, :except => { :no_release => true } do
      require 'erb'
      on_rollback { run "rm #{shared_path}/system/maintenance.html" }

      reason = ENV['REASON']
      deadline = ENV['UNTIL']

      template = File.read(File.join(File.dirname(__FILE__), "./", "maintenance.rhtml"))
      result = ERB.new(template).result(binding)

      put result, "#{shared_path}/system/maintenance.html", :mode => 0644
    end
  end
end

task :restart_nginx do
  sudo '/etc/init.d/nginx reload'
  sudo '/etc/init.d/nginx restart'
end

task :restart_haproxy do
  sudo '/etc/init.d/haproxy restart'
end

task :restart_monit do
  sudo '/etc/init.d/monit restart'
end


namespace :cron do
  task :start, :roles => :web, :only => {:cron => true} do
    cron_tab = "#{shared_path}/cron.tab"
    run "mkdir -p #{shared_path}/log/cron"
    require 'erb'
    template = File.read("config/cron.erb")
    file = ERB.new(template).result(binding)
    put file, cron_tab, :mode => 0644
    # merge with the current crontab
    # fails with an empty crontab, which is acceptable
    run "crontab -l >> #{cron_tab}" rescue nil
    # install the new crontab
    run "crontab #{cron_tab}"
  end

  task :stop, :roles => :web, :only => {:cron => true} do
    cron_tmp = "#{shared_path}/cron.old"
    cron_tab = "#{shared_path}/cron.tab"
    begin
      # dump the current cron entries
      run "crontab -l > #{cron_tmp}"
      # remove any lines that contain the application name
      run "awk '{if ($0 !~ /#{application}/) print $0}' " +
      "#{cron_tmp} > #{cron_tab}"
      # replace the cron entries
      run "crontab #{cron_tab}"
    rescue
      # fails with an empty crontab, which is acceptable
    end
    # clean up
    run "rm -rf #{cron_tmp}"
  end
end

before "deploy:stop", "cron:stop"
after "deploy:start", "cron:start"
