RSpec::Matchers.define :be_installed do
  match do |name|
    if name.respond_to?(:installed?)
      name.installed?(@provider, @version)
    else
      if @provider.nil?
        backend.check_installed(example, name)
      else
        if @provider.include?('/')
          path = @provider
          @provider = @provider.split('/').last
        else
          path = nil
        end
        check_method = "check_installed_by_#{@provider}".to_sym

        unless backend.respond_to?(check_method) || commands.respond_to?(check_method)
          raise ArgumentError.new("`be_installed` matcher doesn't support #{@under}")
        end

        backend.send(check_method, example, name, @version, path)
      end
    end
  end

  chain :by do |provider|
    @provider = provider
  end

  chain :with_version do |version|
    @version = version
  end

end
