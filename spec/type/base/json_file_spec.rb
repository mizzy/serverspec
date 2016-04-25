require 'spec_helper'

set :os, {:family => 'base'}

describe json_file('example.json') do
  let(:stdout) {<<EOF
{
  "json": {
    "title": "this is a json",
    "array" : [
      {
        "title": "array 1"
      },
      {
        "title": "array 2"
      }
    ]
  }
}
EOF
  }

  its(:content) { should include('json') }
  its(:content) { should include('json' => include('title' => 'this is a json')) }
  its(:content) { should include('json' => include('array' => include('title' => 'array 2'))) }
end

