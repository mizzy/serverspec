module Serverspec
  module Helper
    module Darwin
      def commands
        Serverspec::Commands::Darwin.new
      end
    end
  end
end
