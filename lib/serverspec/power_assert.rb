require 'test/unit'
require 'specinfra'

require 'serverspec/helper/type'

PowerAssert.configure do |c|
  c.lazy_inspection = true
end

class Serverspec::TestCase < Test::Unit::TestCase
  extend Serverspec::Helper::Type
  include Serverspec::Helper::Type
end

