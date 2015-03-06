require 'time'

module Serverspec::Type
  class X509Certificate < Base
    def certificate?
      (run_openssl_command_with("-noout").exit_status == 0)
    end

    def subject
      run_openssl_command_with("-subject -noout").stdout.chomp.gsub(/^subject= /,'')
    end

    def issuer
      run_openssl_command_with("-issuer -noout").stdout.chomp.gsub(/^issuer= /,'')
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

    def keylength
      len_str = run_openssl_command_with("-text -noout | grep \"Public-Key\"").stdout.chomp
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

    private
    def run_openssl_command_with(param_str)
      @runner.run_command("openssl x509 -in #{name} #{param_str}")
    end

    def parse_dates_str_to_map(dates_str)
      dates_str.split("\n").inject({}) do |res,line|
        kv_arr = line.split '='
        res.merge({ kv_arr[0].to_sym => Time.parse(kv_arr[1] || '') })
      end
    end
  end
end
