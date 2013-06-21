# --- Install packages we need ---
package 'znc'

#add the unix znc user
user 'znc' do
  comment "this is the ZNC user."
  home "/home/znc"
  shell "/bin/bash"
  system true
  :create
end

directory "/home/znc" do
  owner "znc"
  group "znc"
  mode 00755
  action :create
end

#create the .znc directory tree
directory "/home/znc/.znc" do
  owner "znc"
  group "znc"
  mode 00700
  action :create
end

directory "/home/znc/.znc/configs" do
  owner "znc"
  group "znc"
  mode 00700
  action :create
end

directory "/home/znc/.znc/modules" do
  owner "znc"
  group "znc"
  mode 00700
  action :create
end

directory "/home/znc/.znc/users" do
  owner "znc"
  group "znc"
  mode 00700
  action :create
end

#generate the znc main config file
template "/home/znc/.znc/configs/znc.conf" do
  source "znc.conf.erb"
  mode 0600
  owner "znc"
  group "znc"
  variables({
     :irc_nick => node[:znc_config][:irc_nick],
     :irc_realname => node[:znc_config][:irc_realname]
  })
  action :create_if_missing
end

#generate SSL cert
execute "znc_makepem" do
  command "znc --makepem --datadir /home/znc/.znc"
  user "znc"
  group "znc"
  umask 0177
  creates "/home/znc/.znc/znc.pem"
  action :run
end

template "/etc/init.d/znc" do
  source "debian/init.d/znc.erb"
  mode 0744
  owner "root"
  group "root"
  variables({
     :daemon_name => 'znc',
     :daemon_user => node[:znc_init_script][:znc_run_as],
     :daemon_path => node[:znc_init_script][:znc_bin_path],
     :daemon_desc => node[:znc_init_script][:znc_desc],
     :daemon_opts => node[:znc_init_script][:znc_opts],
     :start_stop_daemon_opts => node[:znc_init_script][:start_stop_daemon_opts],
     :daemon_starttime => node[:znc_init_script][:znc_starttime]
  })
  action :create_if_missing
end

service "znc" do
  action [ :enable, :start ]
end
