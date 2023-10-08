# a puppet manifest that sets up your web servers for the deployment of web_static

$STATIC_CONFIG='\tlocation /hbnb_static {\n\t\talias /data/web_static/current;\n\t\tindex index.html index.htm;\n\t}'
$STATIC_COMMENT='\t# Serve static content'
$ERROR_COMMENT='\t# Custom error page'
$directories = ['/data/', '/data/web_static/', '/data/web_static/releases/', '/data/web_static/shared/', '/data/web_static/releases/test/']

package { 'nginx':
  ensure => 'installed',
}

-> file_line { 'redirect_me':
  ensure => 'present',
  path   => '/etc/nginx/sites-available/default',
  after  => 'listen 80 default_server;',
  line   => 'rewrite ^/redirect_me/?$ https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;',
}

-> file_line { 'custom_header':
  ensure => 'present',
  path   => '/etc/nginx/sites-available/default',
  after  => 'listen 80 default_server;',
  line   => 'add_header X-Served-By 6684-web-01;',
}

-> exec { 'static_config'
  path    => '/usr/bin:/bin',
  command => 'sudo sed -i "/server_name _;/a\\\n$STATIC_COMMENT\n$STATIC_CONFIG" /etc/nginx/sites-available/default',
}

-> exec { 'custom_error'
  path    => '/usr/bin:/bin',
  command => 'sudo sed -i "/server_name _;/a\\\n\n$ERROR_COMMENT\n$CUSTOM_ERROR" /etc/nginx/sites-available/default',
}

-> file { 'home_page':
  ensure  => 'present',
  path    => '/var/www/html/index.html',
  content => 'Hello World!',
}

-> file { $directories:
  ensure  => 'directory',
  owner   => 'ubuntu',
  group   => 'ubuntu',
  recurse => 'remote',
  mode    => '0777',
}

-> file { '/data/web_static/current':
  ensure => link,
  target => '/data/web_static/releases/test/',
}

-> file {'/data/web_static/releases/test/index.html':
  ensure  => present,
  content => 'this webpage is found in data/web_static/releases/test/index.htm \n',
  owner   => 'ubuntu',
  group   => 'ubuntu',
  mode    => '0644',
}

-> service { 'nginx':
  ensure  => 'running',
  require => Package['nginx'],
}
