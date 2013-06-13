shared_examples_for 'support kernel_module be_loaded matcher' do |name|
  describe 'be_loaded' do
    describe kernel_module(name) do
      it { should be_loaded }
    end

    describe kernel_module('invalid-module') do
      it { should_not be_loaded }
    end
  end
end
