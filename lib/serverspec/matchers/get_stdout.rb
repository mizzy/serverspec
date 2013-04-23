RSpec::Matchers.define :get_stdout do |expected|
  match do |command|
      puts <<'EOF'

************************************
"get_stdout" matcher is deprecated.
Use "return_stdout" matcher instead.
************************************

EOF
    ret = backend.do_check(command)
    ret[:stdout] =~ /#{expected}/
  end
end
