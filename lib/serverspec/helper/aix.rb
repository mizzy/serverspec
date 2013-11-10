module Serverspec
  module Helper
    module AIX
      def commands
        Serverspec::Commands::AIX.new
      end
    end
  end
end
