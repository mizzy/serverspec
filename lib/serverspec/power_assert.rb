require 'test/unit'
require 'specinfra'

require 'serverspec/helper/type'
extend Serverspec::Helper::Type
class Test::Unit::TestCase
  extend Serverspec::Helper::Type
  include Serverspec::Helper::Type
end

PowerAssert.configure do |c|
  c.lazy_inspection = true
end

module Serverspec
  module PowerAssert
  end
end

