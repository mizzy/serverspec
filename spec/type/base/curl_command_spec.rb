require 'spec_helper'

set :os, :family => 'base'

describe '#response_code' do
  describe curl_command('http://example.com') do
    let(:stderr) { 'Response-Code: 200' }
    its(:response_code) { should eq(200) }
  end
end

describe '#body' do
  describe curl_command('http://example.com/index.html') do
    let(:stdout) { '<title>Example Domain</title>' }
    its(:body) { should contain 'Example Domain' }
  end
end

describe '#body_as_json' do
  describe curl_command('http://example.com/content.json') do
    let(:stdout) { '{"key":1234}' }
    its(:body_as_json) { should eq({"key" => 1234}) }
  end
end

describe '#curl_command' do
  describe curl_command('http://example.com/content.json') do
    it { expect(subject.send(:curl_command)).to eq("curl --silent --write-out '%{stderr}Response-Code: %{response_code}\\n' 'http://example.com/content.json'") }
  end

  describe curl_command('http://example.com/content.json', cacert: '/ca.pem', cert: '/cert.pem', key: '/key.pem', headers: {'Accept' => 'application/json', 'Built-In' => nil}) do
    it { expect(subject.send(:curl_command)).to eq("curl --silent --write-out '%{stderr}Response-Code: %{response_code}\\n' 'http://example.com/content.json' --cacert '/ca.pem' --cert '/cert.pem' --key '/key.pem' --header 'Accept: application/json' --header 'Built-In;'") }
  end
end
