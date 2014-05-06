RSpec::Matchers.define :match_checksum do |pattern|
  match do |file|
    file.match_checksum(pattern)
  end
end
