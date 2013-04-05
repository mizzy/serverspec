module Serverspec
  module GentooHelper
    def commands
      Serverspec::Commands::Gentoo.new
    end
  end
end
