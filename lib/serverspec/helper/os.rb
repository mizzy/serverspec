module Serverspec
  module Helper
    [
     'DetectOS',
     'AIX',
     'Darwin',
     'Debian',
     'FreeBSD',
     'FreeBSD10',
     'Gentoo',
     'Plamo',
     'RedHat',
     'SmartOS',
     'Solaris',
     'Solaris10',
     'Solaris11',
     'Windows',
    ].each do |os|
      eval <<-EOF
        module #{os}
          include self.class.const_get('SpecInfra').const_get('Helper').const_get('#{os}')
        end
      EOF
    end
  end
end
