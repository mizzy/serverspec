module Serverspec
  module RedHatHelper
    def commands
      Serverspec::Commands::RedHat.new
    end
  end
end
