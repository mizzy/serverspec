module Serverspec
  module Helper
    module Solaris11
      def commands
        Serverspec::Commands::Solaris11.new
      end
    end
  end
end
