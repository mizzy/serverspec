RSpec::Matchers.define :return_exit_status do |status|
  match do |command|
    ret = backend.do_check(command)
    ret[:exit_status].to_i == status
  end
end
