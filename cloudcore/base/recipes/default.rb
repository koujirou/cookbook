cookbook_file "/tmp/epel-release-6-8.noarch.rpm" do
  source "/tmp/epel-release-6-8.noarch.rpm"
  mode 0755
end

template "/etc/pam.d/su" do
  source "/etc/pam.d/su.erb"
end

template "/etc/resolv.conf" do
  source "/etc/resolv.conf.erb"
end

template "/etc/selinux/config" do
  source "/etc/selinux/config.erb"
end

service "ntpd" do
    supports :status => true, :restart => true, :reload => true
    action [ :enable, :start ]
end
template "/etc/ntp.conf" do
  source "/etc/ntp.conf.erb"
  notifies :restart, "service[ntpd]"
end

service "sshd"
template "/etc/ssh/sshd_config" do
  source "/etc/ssh/sshd_config.erb"
  notifies :restart, "service[sshd]"
end

template "/etc/resolv.conf" do
  source "/etc/resolv.conf.erb"
end

template "/etc/sysctl.conf" do
  source "/etc/sysctl.conf.erb"
end

package "epel-release-6-8.noarch.rpm" do
  action :install
  source "/tmp/epel-release-6-8.noarch.rpm"
end

package "gcc" do
  action :install
end

package "gcc-c++" do
  action :install
end

package "openssl-devel" do
  action :install
end

package "make" do
  action :install
end

for service in ["acpid","NetworkManager","anacron","atd","auditd","autofs","bluetooth","conman","cpuspeed","cups","dund","gpm","haldaemon","hidd","ip6tables","irda","kudzu","lm_sensors","lvm2-monitor","mcstrans","mdmonitor","mdmpd","messagebus","microcode_ctl","netplugd","nfs","nscd","oddjobd","pand","pcscd","psacct","rdisc","readahead_early","readahead_later","restorecond","rpcgssd","rpcidmapd","rpcsvcgssd","saslauthd","sendmail","smartd","wpa_supplicant","xfs","ypbind","yum-updatesd","iptables","jexec","isdn"]
  service "#{service}" do
    supports :status => true, :restart => true, :reload => true
    action [ :disable, :stop ]
  end
end

