require 'time'

module Serverspec::Type
  class X509PrivateKey < Base
    def valid?
      runner_res = @runner.run_command("openssl rsa -in #{name} -check -noout")
      ( runner_res.exit_status == 0 && runner_res.stdout.chomp == 'RSA key ok' )
    end

    def encrypted?
      @runner.run_command("grep -wq \"^Proc-Type.*ENCRYPTED$\" #{name}").exit_status == 0
    end

    def has_matching_certificate?(cert_file)
      h1 = @runner.run_command("openssl x509 -noout -modulus -in #{cert_file}")
      h2 = @runner.run_command("openssl rsa -noout -modulus -in #{name}")
      (h1.stdout == h2.stdout) && (h1.exit_status == 0) && (h2.exit_status == 0)
    end
  end
end
