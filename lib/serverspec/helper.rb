require 'etc'

# Backend helpers
require 'serverspec/helper/ssh'
require 'serverspec/helper/exec'
require 'serverspec/helper/puppet'

# Command helpers
require 'serverspec/helper/redhat'
require 'serverspec/helper/debian'
require 'serverspec/helper/gentoo'
require 'serverspec/helper/solaris'
require 'serverspec/helper/darwin'
require 'serverspec/helper/detect_os'

# Obsoleted helpers
require 'serverspec/helper/obsoleted'

# Attributes helper
require 'serverspec/helper/attributes'

# Subject type helper
require 'serverspec/helper/type'
include Serverspec::Helper::Type

module Serverspec
  module Helper
    def subject
      build_options
      super
    end

    def build_options
      Serverspec.options.keys.each do |c|
        value = self.respond_to?(c.to_sym) ?
          self.send(c) : RSpec.configuration.send(c)
        Serverspec.send(:"#{c}=", value)
      end
    end
  end
end
