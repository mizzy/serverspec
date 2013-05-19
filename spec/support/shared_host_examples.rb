shared_examples_for 'support host be_resolvable matcher' do |name|
  describe 'be_resolvable' do
    describe host(name) do
      it { should be_resolvable }
    end

    describe host('invalid-name') do
      it { should_not be_resolvable }
    end
  end
end


shared_examples_for 'support host be_resolvable by matcher' do |name, type|
  describe 'be_resolvable.by' do
    describe host(name) do
      it { should be_resolvable.by(type) }
    end

    describe host('invalid-name') do
      it { should_not be_resolvable.by(type) }
    end
  end
end

shared_examples_for 'support host be_reachable matcher' do |name|
  describe 'be_reachable' do
    context host(name) do
      it { should be_reachable }
    end

    describe host('invalid-host') do
      it { should_not be_reachable }
    end
  end
end

shared_examples_for 'support host be_reachable with matcher' do |name|
  describe 'be_reachable.with' do
    context host(name) do
      it { should be_reachable.with(:proto => "icmp", :timeout=> 1) }
    end
    context host(name) do
      it { should be_reachable.with(:proto => "tcp", :port => 22, :timeout=> 1) }
    end
    context host(name) do
      it { should be_reachable.with(:proto => "udp", :port => 53, :timeout=> 1) }
    end
    context host('invalid-host') do
      it { should_not be_reachable.with(:proto => "udp", :port => 53, :timeout=> 1) }
    end
  end
end
