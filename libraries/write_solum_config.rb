# Encoding: utf-8

module Extensions
  module Templates
    # An extension method for printing out the solum config file.
    def write_solum_config(section = '')
      config = ''
      node[:openstack][:paas][:config][section].each do |key, value|
        config << "#{key}=#{value}\n"
      end if node[:openstack][:paas][:config][section]
      config
    end
  end
end
