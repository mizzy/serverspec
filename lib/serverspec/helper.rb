require 'etc'

# Backend helpers
require 'serverspec/helper/ssh'
require 'serverspec/helper/exec'
require 'serverspec/helper/cmd'
require 'serverspec/helper/winrm'
require 'serverspec/helper/puppet'

# Command helpers
require 'serverspec/helper/redhat'
require 'serverspec/helper/debian'
require 'serverspec/helper/gentoo'
require 'serverspec/helper/plamo'
require 'serverspec/helper/aix'
require 'serverspec/helper/solaris'
require 'serverspec/helper/solaris10'
require 'serverspec/helper/solaris11'
require 'serverspec/helper/smartos'
require 'serverspec/helper/darwin'
require 'serverspec/helper/windows'
require 'serverspec/helper/freebsd'
require 'serverspec/helper/detect_os'

# Attributes helper
require 'serverspec/helper/attributes'
include Serverspec::Helper::Attributes

# Subject type helper
require 'serverspec/helper/type'
include Serverspec::Helper::Type

require 'serverspec/helper/configuration'
