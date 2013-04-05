module Serverspec
  module Backend
    module Exec
      def do_check(cmd, opts={})
        stdout = `#{cmd} 2>&1`
        # In ruby 1.9, it is possible to use Open3.capture3, but not in 1.8
        #stdout, stderr, status = Open3.capture3(cmd)
        { :stdout => stdout, :stderr => nil,
          :exit_code => $?, :exit_signal => nil }
      end
    end
  end
end
