#!/bin/bash

# Apache
# ------------------------
# The Apache server is available at http://localhost:3000
#
# MySQL
# ------------------------
# Externally the MySQL server is available at port 8889, and when running on the VM it is available as a socket or at port 3306 as usual. 
# Username: root Password: root
#
# Technical Details
# ------------------------
# Ubuntu 14.04 64-bit
# Apache 2
# PHP 5.5
# MySQL 5.5



# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo installing $1
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}

php_config_file="/etc/php5/apache2/php.ini"
xdebug_config_file="/etc/php5/mods-available/xdebug.ini"
mysql_config_file="/etc/mysql/my.cnf"

echo 'Updating Package Information'
apt-get -y update >/dev/null 2>&1
apt-get -y upgrade >/dev/null 2>&1

install 'Development Tools' build-essential binutils-doc
install Git git
install Apache apache2
install PHP php5 php5-curl php5-mysql php5-sqlite php5-xdebug

echo 'Configuring PHP'
sed -i "s/display_startup_errors = Off/display_startup_errors = On/g" ${php_config_file}
sed -i "s/display_errors = Off/display_errors = On/g" ${php_config_file}

echo 'Configuring XDebug'
cat << EOF > ${xdebug_config_file}
zend_extension=xdebug.so
xdebug.remote_enable=1
xdebug.remote_connect_back=1
xdebug.remote_port=9000
xdebug.remote_host=10.0.2.2
EOF

debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
install MySQL mysql-server libmysqlclient-dev

sed -i "s/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" ${mysql_config_file}

# Allow root access from any host
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION" | mysql -u root --password=root
echo "GRANT PROXY ON ''@'' TO 'root'@'%' WITH GRANT OPTION" | mysql -u root --password=root

# Restart Services
service apache2 restart
service mysql restart

# Set the default apache folder to the public folder
echo "--- Setting document root ---"
if [[ -L /var/www/html ]] && [[ "$(readlink /var/www/html)" = "/vagrant/public" ]]; then
    echo "www is already linked so skipping this step";
else
    sudo rm -rf /var/www/html
    sudo ln -fs /vagrant/public /var/www/html
fi

echo 'All set, rock on!'
