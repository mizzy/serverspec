require 'etc'

module Serverspec
  module RedHatHelper
    def commands
      Serverspec::Commands::RedHat.new
    end
  end

  module DebianHelper
    def commands
      Serverspec::Commands::Debian.new
    end
  end

  module GentooHelper
    def commands
      Serverspec::Commands::Gentoo.new
    end
  end

  module SolarisHelper
    def commands
      Serverspec::Commands::Solaris.new
    end
  end
end
