require 'facter'
Facter.add("httpd_version") do
  confine :osfamily => %w{RedHat}
  setcode do
    output = '2.2'
    rpm = %x{rpm -qa | grep httpd-2 | awk -F"-" '{ print $2 }'}.chomp
    output = rpm[0, 3]
    output
  end
end
