#!/bin/bash

ip_addr=`ruby get_ip.rb`
rails server -e production -b $ip_addr -p 8080
