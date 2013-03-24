require 'serverspec'
require 'pathname'

RSpec.configure do |c|
  c.before do
    c.host = test_server_host
  end
end
