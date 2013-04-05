module Serverspec
  module Helper
    module Solaris
      def commands
        Serverspec::Commands::Solaris.new
      end
    end
  end
end
