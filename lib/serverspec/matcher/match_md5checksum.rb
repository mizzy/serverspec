RSpec::Matchers.define :match_md5checksum do |pattern|
  match do |file|
    file.match_md5checksum(pattern)
  end
end
