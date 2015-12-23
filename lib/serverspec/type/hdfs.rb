require 'nokogiri'

module Serverspec::Type
  class Hdfs < Base
    def value
      regx = /#{@name}/
      doc = ::Nokogiri::XML( open('/etc/hadoop/conf/hdfs-site.xml') )
      doc.xpath('/configuration/property').each do |property|
      case property.xpath('name').text
        when regx
          return property.xpath('value').text
        end
      end
    end
  end
end
