RSpec::Matchers.define :match_md5checksum do |pattern|
  match do |file|
    if file.respond_to?(:match_md5checksum)
      file.match_md5checksum(pattern)
    else
      backend.check_file_md5checksum(example, file, pattern)
    end
  end
end
