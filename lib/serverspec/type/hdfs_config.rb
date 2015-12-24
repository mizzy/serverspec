module Serverspec::Type
  class HdfsConfig < Base
    def initialize(name=nil)
      super

      begin
        require 'nokogiri'
      rescue LoadError
        fail "nokogiri is not available. Try installing it."
      end
    end

    def value
      regx = /#{@name}/
      @doc = ::Nokogiri::XML( @runner.get_file_content('/etc/hadoop/conf/hdfs-site.xml').stdout.strip )
      @doc.xpath('/configuration/property').each do |property|
      case property.xpath('name').text
        when regx
          ret = property.xpath('value').text
          val = ret.to_s
          return val
        end
      end
    end
  end
end
