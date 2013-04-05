module Serverspec
  module Helper
    module Debian
      def commands
        Serverspec::Commands::Debian.new
      end
    end
  end
end
