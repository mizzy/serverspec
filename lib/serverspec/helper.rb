# Subject type helper
require 'serverspec/helper/type'
class RSpec::Core::ExampleGroup
  extend Serverspec::Helper::Type
  include Serverspec::Helper::Type
end

