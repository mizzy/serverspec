module Serverspec
  module Helper
    module RedHat
      def commands
        Serverspec::Commands::RedHat.new
      end
    end
  end
end
