require 'serverspec'
require 'pathname'

RSpec.configure do |c|
  c.before do
    c.host = File.basename(Pathname.new(example.metadata[:location]).dirname)
  end
end
