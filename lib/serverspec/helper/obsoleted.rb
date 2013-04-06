module Serverspec
  module SshHelper
    def self.included(mod)
      puts "Serverspec::SshHelper in spec/spec_helper.rb is deprecated."
      puts "Use Serverspec::Helper::Ssh instead."
      puts "Or remove spec/spec_helper.rb and run severspec-init again."
      exit 1
    end
  end
  module DebianHelper
    def self.included(mod)
      puts "Serverspec::DebianHelper in spec/spec_helper.rb is deprecated."
      puts "Use Serverspec::Helper::Debian instead."
      puts "Or remove spec/spec_helper.rb and run severspec-init again."
      exit 1
    end
  end
  module GentooHelper
    def self.included(mod)
      puts "Serverspec::GentooHelper in spec/spec_helper.rb is deprecated."
      puts "Use Serverspec::Helper::Gentoo instead."
      puts "Or remove spec/spec_helper.rb and run severspec-init again."
      exit 1
    end
  end
  module RedHatHelper
    def self.included(mod)
      puts "Serverspec::RedHatHelper in spec/spec_helper.rb is deprecated."
      puts "Use Serverspec::Helper::RedHat instead."
      puts "Or remove spec/spec_helper.rb and run severspec-init again."
      exit 1
    end
  end
  module SolarisHelper
    def self.included(mod)
      puts "Serverspec::SolarisHelper in spec/spec_helper.rb is deprecated."
      puts "Use Serverspec::Helper::Solaris instead."
      puts "Or remove spec/spec_helper.rb and run severspec-init again."
      exit 1
    end
  end
end
