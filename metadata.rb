name             'opsworks_sidekiq'
maintainer       'Ryan Schlesinger'
maintainer_email 'ryan@instanceinc.com'
license          'Apache 2.0'
description      'Manages sidekiq on opsworks'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'god'

recipe 'opsworks_sidekiq', 'Launches sidekiq'
