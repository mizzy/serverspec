RSpec::Matchers.define :have_virtual_dir do |vdir|
  match do |subject|
    if subject.class.name == 'Serverspec::Type::IisWebsite'
      subject.has_virtual_dir?(vdir, @path)
    else
      className = subject.class.name
      raise "not supported class #{className}"
    end
  end

  chain :with_path do |path|
    @path = path
  end
end
