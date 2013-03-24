require 'serverspec'
require 'pathname'

PROJECT_ROOT = (Pathname.new(File.dirname(__FILE__)) + '..').expand_path

Dir[PROJECT_ROOT.join("spec/support/**/*.rb")].each { |file| require(file) }

RSpec.configure do |c|
  c.before do
    c.host = test_server_host
  end
end
