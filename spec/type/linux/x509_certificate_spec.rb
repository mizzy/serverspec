require 'spec_helper'

set :os, :family => 'linux'

describe x509_certificate('test.pem') do
  let(:exit_status) { 0 }
  it { should be_certificate }
end

describe x509_certificate('test.pem') do
  let(:exit_status) { 1 }
  it { should_not be_certificate }
end

describe x509_certificate('test.pem') do
  let(:stdout) { sample_subj }
  its(:subject) { should eq '/O=some/OU=thing' }
end

describe x509_certificate('test.pem') do
  let(:stdout) { sample_issuer }
  its(:issuer) { should eq '/O=some/OU=issuer' }
end

describe x509_certificate('test.pem') do
  let(:stdout) { sample_validity }
  it { should be_valid }
  its(:validity_in_days) { should be >= 1000 }
end

describe x509_certificate('test.pem') do
  let(:stdout) { sample_validity2 }
  it { should_not be_valid }
end

describe x509_certificate('test.pem') do
  let(:stdout) { sample_san }
  its(:subject_alt_names) { should eq %w[DNS:*.example.com DNS:www.example.net IP:192.0.2.10] }
end

def sample_subj
  <<'EOS'
subject= /O=some/OU=thing
EOS
end

def sample_issuer
  <<'EOS'
issuer= /O=some/OU=issuer
EOS
end

def sample_validity
  <<'EOS'
notBefore=Jul  1 11:11:00 2000 GMT
notAfter=Jul  1 11:11:00 2050 GMT
EOS
end

def sample_validity2
  <<'EOS'
notBefore=Jul  1 11:11:00 2000 GMT
notAfter=Jul  1 11:11:00 2010 GMT
EOS
end

def sample_san
  <<'EOS'
Certificate:
    Data:
        Version: 3 (0x2)
        X509v3 extensions:
            X509v3 Extended Key Usage:
                TLS Web Server Authentication, TLS Web Client Authentication
            X509v3 Subject Alternative Name:
                DNS:*.example.com, DNS:www.example.net, IP:192.0.2.10
EOS
end
