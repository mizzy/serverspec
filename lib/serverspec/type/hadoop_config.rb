module Serverspec::Type
  class HadoopConfig < Base
    def initialize(name=nil, options={})
      super

      begin
        require 'nokogiri'
      rescue LoadError
        fail "nokogiri is not available. Try installing it."
      end
    end

    def value
     @runner.run_command("find /etc/hadoop/conf/ -type f -name \"*.xml\" ").stdout.split(/\n/).each do |file| 
        @doc = ::Nokogiri::XML( @runner.get_file_content("#{file}").stdout.strip )
        @doc.xpath('/configuration/property').each do |property|
        case property.xpath('name').text
          when /#{@name}/
            ret = property.xpath('value').text
            val = ret.to_s
            return val
          end
        end
      end
    end
  end
end
