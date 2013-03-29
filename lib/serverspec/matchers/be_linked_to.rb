RSpec::Matchers.define :be_linked_to do |target|
  match do |link|
    ret = ssh_exec(commands.check_link(link, target))
    ret[:exit_code] == 0
  end
end
