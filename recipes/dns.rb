include_recipe 'dnsmasq::default'

dns_config = node['dnsmasq']['dns'].to_hash
dns_config['no-dhcp-interface='] = nil unless node['dnsmasq']['enable_dhcp']

template '/etc/dnsmasq.d/dns.conf' do
  source 'dynamic_config.erb'
  mode 0644
  variables(
    :config => dns_config,
    :list => node['dnsmasq']['dns_options']
  )
  notifies :restart, 'service[dnsmasq]', :immediately
end
