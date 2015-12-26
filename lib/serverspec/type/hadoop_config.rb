module Serverspec::Type
  class HadoopConfig < Base
    def initialize(name=nil)
      super

      begin
        require 'nokogiri'
      rescue LoadError
        fail "nokogiri is not available. Try installing it."
      end
    end

    def value
      extra = '';
      extra = extra + "#{@options[:file]}" if @options.has_key?(:file)
      regx = /#{@name}/
      @doc = ::Nokogiri::XML( @runner.get_file_content("#{extra}").stdout.strip )
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
