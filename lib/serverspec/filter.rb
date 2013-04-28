module Serverspec
  class Filter
    def self.filter_subject example
      description_args = example.metadata[:example_group][:example_group][:description_args].join(' ')

      # Linux kernel parameters
      %w( abi crypto debug dev fs kernel net sunrpc vm ).each do |param|
        if description_args.match(/^#{param}\./)
          ret = backend.do_check("sysctl -q -n #{description_args}")
          subject = Serverspec::Subject.new
          subject.value(ret[:stdout].strip.to_i)
          return subject
        end
      end

      example.metadata[:example_group][:description_args].join(' ')
    end
  end
end
