RSpec::Matchers.define :have_ipfilter_rule do |rule|
  match do |iptables|
    backend.check_ipfilter_rule(rule)
  end
end
