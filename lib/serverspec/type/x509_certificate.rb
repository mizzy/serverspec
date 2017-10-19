require 'time'

module Serverspec::Type
  class X509Certificate < Base
    def certificate?
      (run_openssl_command_with("-noout").exit_status == 0)
    end

    def subject
      run_openssl_command_with("-subject -noout").stdout.chomp.gsub(/^subject= */,'')
    end

    def issuer
      run_openssl_command_with("-issuer -noout").stdout.chomp.gsub(/^issuer= */,'')
    end

    def email
      run_openssl_command_with("-email -noout").stdout.chomp
    end

    def fingerprint
      run_openssl_command_with("-fingerprint -noout").stdout.chomp
    end

    def alias
      run_openssl_command_with("-alias -noout").stdout.chomp
    end

    # Modern openssl use following output format for key length:
    # Public-Key: (4096 bit)
    # while ancient (0.9.8 for example) use
    # RSA Public Key: (2048 bit)
    def keylength
      len_str = run_openssl_command_with("-text -noout | grep -E 'Public(-| )Key: \\([[:digit:]]+ bit\\)'").stdout.chomp
      len_str.gsub(/^.*\(/,'').gsub(/ bit\)$/,'').to_i
    end

    def has_purpose?(p)
      grep_str = "#{p} : Yes"
      ( run_openssl_command_with("-purpose -noout | grep -wq \"#{grep_str}\"").
          exit_status == 0 )
    end

    def valid?
      runner_res = run_openssl_command_with("-startdate -enddate -noout")
      return false if runner_res.exit_status != 0

      date_map = parse_dates_str_to_map(runner_res.stdout)

      now = Time.now
      ( now >= date_map[:notBefore] && now <= date_map[:notAfter])
    end

    def validity_in_days
      runner_res = run_openssl_command_with("-enddate -noout")
      return 0 if runner_res.exit_status != 0

      date_map = parse_dates_str_to_map(runner_res.stdout)
      diff = date_map[:notAfter] - Time.now
      ( diff/(60*60*24) )
    end

    def subject_alt_names
      text = run_openssl_command_with('-text -noout').stdout
      # X509v3 Subject Alternative Name:
      #     DNS:*.example.com, DNS:www.example.net, IP:192.0.2.10
      if text =~ /^ *X509v3 Subject Alternative Name:.*\n *(.*)$/
        $1.split(/, +/)
      end
    end

    private
    def run_openssl_command_with(param_str)
      @runner.run_command("openssl x509 -in #{name} #{param_str}")
    end

    def parse_dates_str_to_map(dates_str)
      dates_str.split("\n").inject({}) do |res,line|
        kv_arr = line.split '='
        time = Time.strptime(kv_arr[1],'%b %e %T %Y %Z') rescue Time.parse(kv_arr[1] || '')
        res.merge({ kv_arr[0].to_sym => time })
      end
    end
  end
end
