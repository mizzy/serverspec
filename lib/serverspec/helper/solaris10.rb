module Serverspec
  module Helper
    module Solaris10
      def commands
        Serverspec::Commands::Solaris10.new
      end
    end
  end
end
