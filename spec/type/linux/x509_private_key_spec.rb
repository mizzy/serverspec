require 'spec_helper'

set :os, :family => 'linux'

describe x509_private_key('key.pem') do
  let(:exit_status) { 0 }
  let(:stdout) { 'RSA key ok' }
  it { is_expected.to be_valid }
end

describe x509_private_key('key.pem') do
  let(:exit_status) { 1 }
  let(:stdout) { 'RSA key ok' }
  it { is_expected.to_not be_valid }
end

describe x509_private_key('key.pem') do
  let(:exit_status) { 0 }
  it { is_expected.to be_encrypted }
end

describe x509_private_key('key.pem') do
  let(:exit_status) { 1 }
  it { is_expected.to_not be_encrypted }
end

describe x509_private_key('key.pem') do
  let(:exit_status) { 0 }
  let(:stdout) { 'SHA1SUM' }
  it { is_expected.to have_matching_certificate('cert.pem') }
end