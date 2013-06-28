module Serverspec
  module Helper
    module FreeBSD
      def commands
        Serverspec::Commands::FreeBSD.new
      end
    end
  end
end
