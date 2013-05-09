RSpec::Matchers.define :have_md5checksum do |pattern|
  match do |file|
    ret = backend.run_command(backend.commands.check_file_md5checksum(file, pattern))
    ret[:exit_status] == 0
  end
end
