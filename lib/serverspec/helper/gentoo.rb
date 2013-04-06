module Serverspec
  module Helper
    module Gentoo
      def commands
        Serverspec::Commands::Gentoo.new
      end
    end
  end
end
