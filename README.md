# biz.php7

## Requirements
- [Vagrant 1.7.4](https://www.vagrantup.com)
- [Virtual Box 5.0](https://www.virtualbox.org/)
- [Berkshelf 0.10.0](https://downloads.chef.io/chef-dk/)
- Vagrant plugins:
  - hostmanager
  - berkshelf
  - vbguest
  - omnibus

## Install
Before provision [Vagrant](https://www.vagrantup.com) make sure everything is already install.

To install [Vagrant](https://www.vagrantup.com), [Virtual Box](https://www.virtualbox.org/) and [Berkshelf](https://downloads.chef.io/chef-dk/) you can simply download them and do the "next-next" steps until reach the end.

### Vagrant Plugins
To install [Vagrant](https://www.vagrantup.com) plugins do the following:
```sh
$ vagrant plugin install vagrant-hostmanager
$ vagrant plugin install vagrant-berkshelf
$ vagrant plugin install vagrant-vbguest
$ vagrant plugin install vagrant-omnibus
```
**Note**: Remember that `$` and `#` symbols are only for visual purposes, they mean regular user and sudo user. There's no add these signs to execute your commands.

### Ports
Only this ports are available for binding:
- 8080 (http)
- 8443 (https)
- 3036 (MySQL)

If there is a need for using a new port, you can simply change and commit the *Vagrantfile*. **Don't** forget to update this `README.md` file.

### What's inside
- [MySQL 5.5](https://www.mysql.com/)
- [PHP 5.6+](http://php.net/)
  - [PHPUnit](https://phpunit.de)
  - [Composer](https://getcomposer.org/)

#### MySQL
The MySQL connection parameters are:
```
Host: `localhost`
User: `root`
Pass: `root`
Port: `3306`
```

#### HTTP
While we don't see a real need for using HTTP server we'll keep with PHP built-in server.

Just need to run the following command as sudo:
```sh
# php -S 0.0.0.0:80 index.php
```

## Provision
After all the steps above it's time to provision the box.

At the first moment, and only at this moment, it's going to download the box and do the provisioning.

Do the following:
```sh
$ vagrant up
```

If some attributes, recipes, packages, whatever, were changed and you need to force the provision:
```sh
$ vagrant provision
```

## Authors
- Hudson Dunice (<hudson.dunice@bizairlines.com>)
