RSpec::Matchers.define :be_listening do
  match do |actual|
    port = actual.gsub(/port\s+/, '')
    ret = do_check(commands.check_listening(port))
    ret[:exit_code] == 0
  end
end
