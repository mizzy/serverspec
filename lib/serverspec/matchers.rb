# file
require 'serverspec/matchers/be_mounted'
require 'serverspec/matchers/contain'
require 'serverspec/matchers/be_readable'
require 'serverspec/matchers/be_writable'
require 'serverspec/matchers/be_executable'
require 'serverspec/matchers/match_md5checksum'

# host
require 'serverspec/matchers/be_resolvable'
require 'serverspec/matchers/be_reachable'

# package
require 'serverspec/matchers/be_installed'

# service
require 'serverspec/matchers/be_enabled'
require 'serverspec/matchers/be_running'

# user
require 'serverspec/matchers/belong_to_group'

require 'serverspec/matchers/return_exit_status'
require 'serverspec/matchers/return_stdout'
require 'serverspec/matchers/return_stderr'

# ipfiter, ipnat, iptables
require 'serverspec/matchers/have_rule'

# cron, routing_table
require 'serverspec/matchers/have_entry'
