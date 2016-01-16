#
# Cookbook Name:: biz.php7
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute

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

include_recipe "apt"

execute "/usr/bin/apt-get update"
package "python-software-properties"
execute "add-apt-repository ppa:ondrej/php5-5.6"
execute "/usr/bin/apt-get update"

package "build-essential"
package "git-core"
package "make"
package "gcc"
package "vim"
package "wget"
package "curl"
package "php5"
package "php5-dev"
package "php5-mysql"
package "php5-fpm"
package "php5-cgi"
package "php5-curl"
package "php5-gd"
package "php5-intl"
package "php5-mcrypt"
package "php5-pgsql"
package "php5-sqlite"
package "php5-mysql"
package "php5-tidy"
package "php5-xmlrpc"

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
execute "service apache2 stop"
execute "update-rc.d -f  apache2 remove"
