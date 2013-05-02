module Serverspec
  class Filter
    def self.filter_subject example
      description_args = example.metadata[:example_group][:example_group][:description_args].join(' ')

      # Linux kernel parameters
      %w( abi crypto debug dev fs kernel net sunrpc vm ).each do |param|
        if description_args.match(/^#{param}\./)
          ret = backend(Serverspec::Commands::Base).do_check("/sbin/sysctl -q -n #{description_args}")
          val = ret[:stdout].strip
          val = val.to_i if val.match(/^\d+$/)
          subject = Serverspec::Subject.new
          subject.value(val)
          return subject
        end
      end

      example.metadata[:example_group][:description_args].join(' ')
    end
  end
end
