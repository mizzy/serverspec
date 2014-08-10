RSpec::Matchers.define :match_sha256checksum do |pattern|
  match do |file|
    file.match_sha256checksum(pattern)
  end
end
