RSpec::Matchers.define :match_md5checksum do |pattern|
  match do |file|
    backend.check_file_md5checksum(example, file, pattern)
  end
end
