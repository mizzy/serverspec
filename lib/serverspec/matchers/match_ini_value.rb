RSpec::Matchers.define :match_ini_value do |pattern|
  match do |entry|
    entry.match_ini_value(pattern)
  end
end
