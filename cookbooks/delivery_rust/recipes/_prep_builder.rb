case node['platform_family']
when 'rhel', 'fedora'
  # centos needs to have the default install prefix for rust added to
  # ld.so.conf
  file "/etc/ld.so.conf.d/rust-x86_64.conf" do
    content <<-EOH
  /usr/local/lib
  EOH
    mode "0644"
  end

  execute "reload ldconfig" do
    command "ldconfig"
  end

  package "git"

  include_recipe "delivery_rust::_omnibus"
when 'debian'
  execute "update apt cache" do
    command "apt-get update"
    not_if "test -f /tmp/apt-get-update-marker"
  end

  file "/tmp/apt-get-update-marker" do
    content "Laste Update: #{Time.now.utc}"
    not_if "test -f /tmp/apt-get-update-marker"
  end

  package "curl"
  package "git"

  include_recipe "delivery_rust::_omnibus"
when 'windows'
when 'mac_os_x'
else
  log "Unrecognized platform_family '#{node['platform_family']}'"
end