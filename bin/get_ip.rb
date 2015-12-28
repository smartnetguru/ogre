# Needs system-getifaddrs

require "system/getifaddrs"
ip_addr = System.get_all_ifaddrs.select do |iface|
  iface[:interface] == 'eth0'
end.first[:inet_addr]
puts ip_addr
