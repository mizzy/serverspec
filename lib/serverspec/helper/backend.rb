module Serverspec
  module Helper
    ['Exec', 'Ssh', 'Cmd', 'WinRM'].each do |backend|
      eval <<-EOF
        module #{backend}
          include self.class.const_get('SpecInfra').const_get('Helper').const_get('#{backend}')
        end
      EOF
    end
  end
end
