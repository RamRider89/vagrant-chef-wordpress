#
# Cookbook:: wordpress
# Recipe:: default
#
# Copyright:: 2025, The Authors, All Rights Reserved.

# Descargar el archivo de WordPress
remote_file '/tmp/latest.tar.gz' do
    source 'https://wordpress.org/latest.tar.gz'
end

# Extraer WordPress en el directorio /var/www/html
execute 'extract-wordpress' do
    command 'sudo tar -xzvf /tmp/latest.tar.gz -C /var/www/html/ --strip-components=1'
    creates '/var/www/html/wp-settings.php'
end

# Generación del archivo wp-config.php
template '/var/www/html/wp-config.php' do
    source 'wp-config.erb'
    variables(
        db_name: 'wordpress',
        db_user: 'wordpress',
        db_password: 'admin123',
        db_host: 'localhost',
        db_charset: 'utf8mb4'
    )
end
  
# Instalación de WordPress
execute 'install-wordpress' do
    command 'sudo -u www-data wp-cli core install --path=/var/www/html --url=http://192.168.100.37:8080 --title="Blog WordPress Chef" --admin_user=admin --admin_password=admin123 --admin_email=david.duarte@davdav.tech'
    not_if 'sudo -u www-data wp-cli core is-installed --path=/var/www/html'
end
  
# Eliminar el archivo index.html predeterminado si existe
execute 'remove-index-html' do
    command 'sudo /bin/rm -f /var/www/html/index.html'
    only_if '/bin/ls /var/www/html/index.html'
end