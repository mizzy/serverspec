require 'spec_helper'

set :os, :family => 'linux'

describe x509_private_key('key.pem') do
  let(:exit_status) { 0 }
  let(:stdout) { 'RSA key ok' }
  it { should be_valid }
end

describe x509_private_key('key.pem') do
  let(:exit_status) { 1 }
  let(:stdout) { 'RSA key ok' }
  it { should_not be_valid }
end

describe x509_private_key('key.pem') do
  let(:exit_status) { 0 }
  it { should be_encrypted }
end

describe x509_private_key('key.pem') do
  let(:exit_status) { 1 }
  it { should_not be_encrypted }
end

describe x509_private_key('key.pem') do
  let(:exit_status) { 0 }
  let(:stdout) { 'SHA1SUM' }
  it { should have_matching_certificate('cert.pem') }
end