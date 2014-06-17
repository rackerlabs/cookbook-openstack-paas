# Encoding: utf-8

module Extensions
  module Templates
    # An extension method for printing out the solum config file.
    def write_solum_config(input = {})
      config = ''
      input.each do |section, content|
        config << "[#{section}]\n"
        content.each do |key, value|
          config << "#{key}=#{value}\n"
        end
        config << "\n\n"
      end
      config
    end
  end
end
