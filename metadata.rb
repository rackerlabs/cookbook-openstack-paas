# Encoding: utf-8
name             'solum'
maintainer       'YOUR_COMPANY_NAME'
maintainer_email 'none'
license          ''
description      'Installs/Configures solum'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w(apt git python build-essential runit).each do |dep|
  depends dep
end
