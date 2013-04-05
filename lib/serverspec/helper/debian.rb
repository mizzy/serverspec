module Serverspec
  module DebianHelper
    def commands
      Serverspec::Commands::Debian.new
    end
  end
end
