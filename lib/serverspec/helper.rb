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
require 'serverspec/helper/os_detect'

# Obsoleted helpers
require 'serverspec/helper/obsoleted'
