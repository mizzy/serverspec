require 'etc'

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

