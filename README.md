# DNSMasq

Install and configure dnsmasq. Depends on the [hosts_file cookbook](https://github.com/hw-cookbooks/hosts_file).

# Recipes

## default
Installs the `dnsmasq` package. Depending on the `[:dnsmasq][:enable_dns]` and `[:dnsmasq][:enable_dhcp]` attributes it includes the `dns` and `dhcp` recipes respectively.

## dhcp

Includes the `default` recipe and writes the contents of the `node[:dnsmasq][:dhcp]` attribute hash to `/etc/dnsmasq.d/dhcp.conf`. Here is an example of the necessary attributes for DHCP with TFTP enabled:

```ruby
'dnsmasq' => {
  'enable_dhcp' => true,
  'dhcp' => {
    'dhcp-authoritative' => nil,
    'dhcp-range' => 'eth0,10.0.0.10,10.0.0.100,12h',
    'dhcp-option' => '3', #turns off everything except basic DHCP
    'domain' => 'lab.atx',
    'interface' => 'eth0',
    'dhcp-boot' => 'pxelinux.0',
    'enable-tftp' => nil,
    'tftp-root' => '/var/lib/tftpboot',
    'tftp-secure' => nil
  }
}
```

## dns

Includes the `default` recipe, then writes the content of the `node[:dnsmasq][:dns]` attribute hash to `/etc/dnsmasq.d/dns.conf`.

## Attributes

* `[:dnsmasq][:enable_dns]` whether to enable the DNS service, default is `true`
* `[:dnsmasq][:enable_dhcp]` whether to enabled the DHCP service, default is `false`
* `[:dnsmasq][:dhcp]` = hash of settings and values for the `/etc/dnsmasq.d/dhcp.conf`, default is empty
* `[:dnsmasq][:dhcp_options]` = list of options to be added to the `/etc/dnsmasq.d/dhcp.conf` (ie. `['dhcp-host=80:ee:73:0a:fa:d9,crushinator,10.0.0.11']`), default is empty.
* `[:dnsmasq][:dns]` hash of settings and values for the `/etc/dnsmasq.d/dns.conf`, defaults are
```ruby
{
  'no-poll' => nil,
  'no-resolv' => nil,
  'server' => '127.0.0.1'
}
```
* `[:dnsmasq][:dns_options]` = list of options to be added to the `/etc/dnsmasq.d/dns.conf`, default is empty.

## Testing

Please refer to the [TESTING file](TESTING.md) to see instructions for testing this cookbook. It is currently tested on the following platforms: CentOS 5.9, CentOS 6.4, Debian 7.1, Ubuntu 10.04, 12.04 and 13.04.

# Repo:

* https://github.com/hw-cookbooks/dnsmasq
