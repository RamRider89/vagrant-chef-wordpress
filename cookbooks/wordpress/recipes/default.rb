#
# Cookbook:: default
# Recipe:: default
#
# Copyright:: 2025, The Authors, All Rights Reserved.

# Actualiza la lista de paquetes
apt_update 'update_package_list' do
  action :update
end

# Instalación de wp-cli
execute 'install-wp-cli' do
  command 'curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && sudo mv wp-cli.phar /usr/local/bin/wp-cli'
  not_if 'which wp-cli'
end

# Instalación de apache php y mysql
packages = %w(apache2 ghostscript libapache2-mod-php mysql-server php php-bcmath php-curl php-imagick php-intl php-json php-mbstring php-mysql php-xml php-zip)

packages.each do |pkg|
  package pkg do
    action :install
  end
end

# Habilitar y empezar el servicio Apache
service 'apache2' do
  action [:enable, :start]
end

# modulo apache
execute 'modulo-apache' do
  command "sudo a2enmod rewrite"
  sensitive true
end

execute 'reset-apache' do
  command "sudo systemctl restart apache2"
  sensitive true
end

# Requerir la receta de la base de datos
include_recipe 'wordpress::database'

# Requerir la receta descarga e instalacion de wordpress
include_recipe 'wordpress::wordpress'