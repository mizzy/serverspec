require 'serverspec/type/base'
require 'serverspec/type/service'
require 'serverspec/type/package'
require 'serverspec/type/port'
require 'serverspec/type/file'
require 'serverspec/type/cron'

module Serverspec
  module Helper
    module Type
      %w( service package port file cron ).each do |type|
        define_method type do |*args|
          name = args.first
          self.class.const_get('Serverspec').const_get('Type').const_get(type.capitalize).new(name)
        end
      end
    end
  end
end
