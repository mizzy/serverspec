module Serverspec
  module Type
    class Uri < Base
      def http_get_matches_status_code?(status_code)
        response = backend.run_command("curl -i #{@name}").stdout
        /^HTTP\/1.\d (?<status_code>\d+)/.match(response)[:status_code] == status_code.to_s
      end
    end
  end
end
