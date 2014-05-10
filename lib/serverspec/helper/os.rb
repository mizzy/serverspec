module Serverspec
  module Helper
    [
      'DetectOS',
      'AIX',
      'Arch',
      'Darwin',
      'Debian',
      'Fedora',
      'FreeBSD',
      'FreeBSD10',
      'Gentoo',
      'Plamo',
      'RedHat',
      'RedHat7',
      'SmartOS',
      'Solaris',
      'Solaris10',
      'Solaris11',
      'Windows',
    ].each do |os|
      eval <<-EOF
        module #{os}
          include self.class.const_get('Specinfra').const_get('Helper').const_get('#{os}')
        end
      EOF
    end
  end
end
