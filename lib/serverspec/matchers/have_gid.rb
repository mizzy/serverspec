RSpec::Matchers.define :have_gid do |gid|
  match do |group|
    backend.check_gid(example, group, gid)
  end
end

