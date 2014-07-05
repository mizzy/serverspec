require 'spec_helper'

include Specinfra::Helper::RedHat

describe Serverspec::Type::Port do
  describe port(80) do
    it { should be_listening }

    it('protocol: tcp') { should be_listening.with('tcp') }

    it 'invalid protocol raises error' do
      expect {
        should be_listening.with('not implemented')
      }.to raise_error(ArgumentError, %r/\A`be_listening` matcher doesn\'t support/)
    end

    it('on: 127.0.0.1') do
      should be_listening.on('127.0.0.1')
    end

    it 'invalid local address raises error' do
      expect{ should be_listening.on('') }.to raise_error(ArgumentError)
    end
  end

  describe port('invalid') do
    it { should_not be_listening }
  end

  describe port(123) do
    it { should be_listening.with("udp") }
  end
end
