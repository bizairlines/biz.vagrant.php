#
# Cookbook Name:: biz.php
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute

include_recipe "apt"
include_recipe "openssl"

execute "/usr/bin/apt-get update"
package "build-essential"

include_recipe "postgresql::server"

mysql_user = "root"
mysql_pass = "root"
mysql_serv = "default"

mysql_service mysql_serv do
  port '3306'
  version '5.5'
  run_user mysql_pass
  initial_root_password mysql_user
  bind_address '0.0.0.0'
  action [:create, :start]
end

package "python-software-properties"
execute "add-apt-repository ppa:ondrej/php"
execute "/usr/bin/apt-get update"

package "git-core"
package "make"
package "gcc"
package "libpcre3-dev"
package "vim"
package "wget"
package "curl"
package "php7.0"
package "php7.0-dev"
package "php7.0-mysql"
package "php7.0-fpm"
package "php7.0-cgi"
package "php7.0-curl"
package "php7.0-gd"
package "php7.0-intl"
package "php7.0-mcrypt"
package "php7.0-pgsql"
package "php7.0-sqlite"
package "php7.0-tidy"

execute "/usr/bin/mysql -u#{mysql_user} -p#{mysql_pass} -S /run/mysql-default/mysqld.sock -e \"GRANT ALL PRIVILEGES ON *.* TO '#{mysql_user}'@'%' IDENTIFIED BY '#{mysql_pass}' WITH GRANT OPTION;\""
execute "/usr/bin/mysql -u#{mysql_user} -p#{mysql_pass} -S /run/mysql-default/mysqld.sock -e \"FLUSH PRIVILEGES;\""

# Install Composer or update if it's already installed
if File.exists?("/usr/bin/composer")
  execute "/usr/bin/composer self-update --no-progress"
else
  execute "curl -sS https://getcomposer.org/installer | php -- --filename=composer"
  execute "/bin/mv composer /usr/bin/composer"
end

# Install PHPUnit
if not File.exists?("/usr/local/bin/phpunit")
  execute "wget https://phar.phpunit.de/phpunit.phar --quiet"
  execute "/bin/chmod +x phpunit.phar"
  execute "/bin/mv phpunit.phar /usr/local/bin/phpunit"
end

# Stop Apache and remove it from auto start
# execute "service apache2 stop"
# execute "update-rc.d -f  apache2 remove"
