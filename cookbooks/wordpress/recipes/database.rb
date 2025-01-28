#
# Cookbook:: database
# Recipe:: default
#
# Copyright:: 2025, The Authors, All Rights Reserved.

# Configuración de la base de datos MySQL
execute 'create-wordpress-db' do
    command "sudo mysql -u root -e \"CREATE DATABASE IF NOT EXISTS wordpress;\""
    sensitive true
end
  
# Crear usuario de WordPress en la base de datos MySQL
execute 'create-wordpress-user' do
    command "sudo mysql -u root -e \"CREATE USER IF NOT EXISTS wordpress@localhost IDENTIFIED BY 'admin123';\""
    sensitive true
end

# Permisos de usuario
execute 'permisos-user' do
    command "sudo mysql -u root -e \"GRANT ALL PRIVILEGES ON wordpress.* TO wordpress@localhost; FLUSH PRIVILEGES;\""
    sensitive true
end