# -*- coding: utf-8 -*-
require 'spec_helper'

property[:os] = nil
set :os, {:family => 'linux'}

describe docker_image('busybox:latest') do
  it { should exist }
end

describe docker_image('busybox:latest') do
  let(:stdout) { inspect_image }
  its(:inspection) { should include 'Architecture' => 'amd64' }
  its(['Architecture']) { should eq 'amd64' }
  its(['Config.Cmd']) { should include '/bin/sh' }
end

def inspect_image
  <<'EOS'
[{
    "Architecture": "amd64",
    "Author": "Jérôme Petazzoni \u003cjerome@docker.com\u003e",
    "Comment": "",
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
        "Hostname": "88f18f678e5d",
        "Image": "e433a6c5b276a31aa38bf6eaba9cd1cfd69ea33f706ed72b3f20bafde5cd8644",
        "Memory": 0,
        "MemorySwap": 0,
        "NetworkDisabled": false,
        "OnBuild": [],
        "OpenStdin": false,
        "PortSpecs": null,
        "StdinOnce": false,
        "Tty": false,
        "User": "",
        "Volumes": null,
        "WorkingDir": ""
    },
    "Container": "8e73b239682fe73338323d9af83d3c5aa5bb7d22a3fe84cbfcf5f47e756d6636",
    "ContainerConfig": {
        "AttachStderr": false,
        "AttachStdin": false,
        "AttachStdout": false,
        "Cmd": [
            "/bin/sh",
            "-c",
            "#(nop) CMD [/bin/sh]"
        ],
        "CpuShares": 0,
        "Cpuset": "",
        "Domainname": "",
        "Entrypoint": null,
        "Env": [
            "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
        ],
        "ExposedPorts": null,
        "Hostname": "88f18f678e5d",
        "Image": "e433a6c5b276a31aa38bf6eaba9cd1cfd69ea33f706ed72b3f20bafde5cd8644",
        "Memory": 0,
        "MemorySwap": 0,
        "NetworkDisabled": false,
        "OnBuild": [],
        "OpenStdin": false,
        "PortSpecs": null,
        "StdinOnce": false,
        "Tty": false,
        "User": "",
        "Volumes": null,
        "WorkingDir": ""
    },
    "Created": "2014-10-01T20:46:08.914288461Z",
    "DockerVersion": "1.2.0",
    "Id": "e72ac664f4f0c6a061ac4ef332557a70d69b0c624b6add35f1c181ff7fff2287",
    "Os": "linux",
    "Parent": "e433a6c5b276a31aa38bf6eaba9cd1cfd69ea33f706ed72b3f20bafde5cd8644",
    "Size": 0
}
]
EOS
end
