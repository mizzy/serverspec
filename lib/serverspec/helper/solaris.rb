module Serverspec
  module SolarisHelper
    def commands
      Serverspec::Commands::Solaris.new
    end
  end
end
