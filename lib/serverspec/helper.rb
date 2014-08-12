# Subject type helper
require 'serverspec/helper/type'
extend Serverspec::Helper::Type
class RSpec::Core::ExampleGroup
  extend Serverspec::Helper::Type
  include Serverspec::Helper::Type
end

