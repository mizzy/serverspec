# -*- coding: utf-8 -*-
require 'spec_helper'

property[:os] = nil
set :os, {:family => 'linux'}

describe docker_container('c1') do
  it { should exist }
end

describe docker_container('c1') do
  let(:stdout) { inspect_container }
  it { should be_running }
  it { should have_volume('/tmp', '/data') }
  its(:inspection) { should include 'Driver' => 'aufs' }
  its(['Config.Cmd']) { should include '/bin/sh' }
end

def inspect_container
  <<'EOS'
[{
    "Args": [],
    "Config": {
        "AttachStderr": false,
        "AttachStdin": false,
        "AttachStdout": false,
        "Cmd": [
            "/bin/sh"
        ],
        "CpuShares": 0,
        "Cpuset": "",
        "Domainname": "",
        "Entrypoint": null,
        "Env": [
            "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
        ],
        "ExposedPorts": null,
        "Hostname": "65cd2e2d7963",
        "Image": "busybox",
        "Memory": 0,
        "MemorySwap": 0,
        "NetworkDisabled": false,
        "OnBuild": null,
        "OpenStdin": true,
        "PortSpecs": null,
        "StdinOnce": false,
        "Tty": true,
        "User": "",
        "Volumes": null,
        "WorkingDir": ""
    },
    "Created": "2014-09-26T15:08:37.527931773Z",
    "Driver": "aufs",
    "ExecDriver": "native-0.2",
    "HostConfig": {
        "Binds": [
            "/data:/tmp"
        ],
        "ContainerIDFile": "",
        "Dns": null,
        "DnsSearch": null,
        "Links": null,
        "LxcConf": [],
        "NetworkMode": "bridge",
        "PortBindings": {},
        "Privileged": false,
        "PublishAllPorts": false,
        "VolumesFrom": null
    },
    "HostnamePath": "/mnt/sda1/var/lib/docker/containers/65cd2e2d7963bacaecda2d7fcd89499010bc0d38d70bce5ad0af7112a94a4545/hostname",
    "HostsPath": "/mnt/sda1/var/lib/docker/containers/65cd2e2d7963bacaecda2d7fcd89499010bc0d38d70bce5ad0af7112a94a4545/hosts",
    "Id": "65cd2e2d7963bacaecda2d7fcd89499010bc0d38d70bce5ad0af7112a94a4545",
    "Image": "e72ac664f4f0c6a061ac4ef332557a70d69b0c624b6add35f1c181ff7fff2287",
    "MountLabel": "",
    "Name": "/c1",
    "NetworkSettings": {
        "Bridge": "docker0",
        "Gateway": "172.17.42.1",
        "IPAddress": "172.17.0.24",
        "IPPrefixLen": 16,
        "PortMapping": null,
        "Ports": {}
    },
    "Path": "/bin/sh",
    "ProcessLabel": "",
    "ResolvConfPath": "/mnt/sda1/var/lib/docker/containers/65cd2e2d7963bacaecda2d7fcd89499010bc0d38d70bce5ad0af7112a94a4545/resolv.conf",
    "State": {
        "ExitCode": 0,
        "FinishedAt": "0001-01-01T00:00:00Z",
        "Paused": false,
        "Pid": 4123,
        "Running": true,
        "StartedAt": "2014-09-26T15:08:37.737780273Z"
    },
    "Volumes": {
        "/tmp": "/data"
    },
    "VolumesRW": {
        "/tmp": true
    }
}
]
EOS
end
