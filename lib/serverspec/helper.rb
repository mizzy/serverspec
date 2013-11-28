require 'etc'

# Backend helpers
require 'serverspec/helper/ssh'
require 'serverspec/helper/exec'
require 'serverspec/helper/cmd'
require 'serverspec/helper/winrm'
require 'serverspec/helper/puppet'

# Command helpers
require 'serverspec/helper/detect_os'

# Attributes helper
require 'serverspec/helper/attributes'
include Serverspec::Helper::Attributes

# Properties helper
require 'serverspec/helper/properties'
include Serverspec::Helper::Properties

# Subject type helper
require 'serverspec/helper/type'
include Serverspec::Helper::Type

require 'serverspec/helper/configuration'
