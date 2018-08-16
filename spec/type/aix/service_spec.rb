require 'spec_helper'

set :os, :family => 'aix'

describe service('sshd') do
  let(:stdout) { inspect_service }
  it { should be_enabled }
  its('number_of_restarts') { should be 0 }
  its(:inspection) { should include 'MemoryCurrent' => '4067328' }
  its(['RestartUSec']) { should eq '42s' }
end

describe service('sshd') do
  it { should be_enabled.with_level(4) }
end

def inspect_service
  <<'EOS'
Type=notify
Restart=on-failure
NotifyAccess=main
RestartUSec=42s
TimeoutStartUSec=1min 30s
TimeoutStopUSec=1min 30s
WatchdogUSec=0
WatchdogTimestamp=Mon 2018-01-08 13:18:51 CST
WatchdogTimestampMonotonic=16678908
StartLimitInterval=10000000
StartLimitBurst=5
StartLimitAction=none
FailureAction=none
PermissionsStartOnly=no
RootDirectoryStartOnly=no
RemainAfterExit=no
GuessMainPID=yes
MainPID=971
ControlPID=0
FileDescriptorStoreMax=0
StatusErrno=0
Result=success
ExecMainStartTimestamp=Mon 2018-01-08 13:18:51 CST
ExecMainStartTimestampMonotonic=16538549
ExecMainExitTimestampMonotonic=0
ExecMainPID=971
ExecMainCode=0
ExecMainStatus=0
ExecStart={ path=/usr/sbin/sshd ; argv[]=/usr/sbin/sshd -D $OPTIONS ; ignore_errors=no ; start_time=[Mon 2018-01-08 13:18:51 CST] ; stop_time=[n/a] ; pid=971 ; code=(null) ; status=0/0 }
ExecReload={ path=/bin/kill ; argv[]=/bin/kill -HUP $MAINPID ; ignore_errors=no ; start_time=[n/a] ; stop_time=[n/a] ; pid=0 ; code=(null) ; status=0/0 }
Slice=system.slice
ControlGroup=/system.slice/sshd.service
MemoryCurrent=4067328
Delegate=no
CPUAccounting=no
CPUShares=18446744073709551615
StartupCPUShares=18446744073709551615
CPUQuotaPerSecUSec=infinity
BlockIOAccounting=no
BlockIOWeight=18446744073709551615
StartupBlockIOWeight=18446744073709551615
MemoryAccounting=no
MemoryLimit=18446744073709551615
DevicePolicy=auto
EnvironmentFile=/etc/sysconfig/sshd (ignore_errors=no)
UMask=0022
LimitCPU=18446744073709551615
EOS
end
