RSpec::Matchers.define :have_gid do |gid|
  match do |group|
    if group.respond_to?(:has_gid?)
      group.has_gid?(gid)
    else
      backend.check_gid(example, group, gid)
    end
  end
end

