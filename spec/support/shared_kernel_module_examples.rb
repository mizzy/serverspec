shared_examples_for 'kernel module' do 
  describe 'be_loaded' do
    describe kernel_module('lp') do
      it { should be_loaded }
    end

    describe kernel_module('invalid-module') do
      it { should_not be_loaded }
    end
  end
end

