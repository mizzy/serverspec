shared_examples_for 'support group exist matcher' do |name|
  describe 'group exist' do
    describe group(name) do
      it { should be_group }
    end

    describe group('invalid-group') do
      it { should_not be_group }
    end
  end
end

shared_examples_for 'support group have_gid matcher' do |name, gid|
  describe 'have_gid' do
    describe group(name) do
      it { should have_gid gid }
    end

    describe group(name) do
      it { should_not have_gid 'invalid-gid' }
    end
  end
end
