shared_examples_for 'support explicit linux kernel parameter checking with integer' do |param, value|
  describe 'linux kernel parameter' do
    before :all do
      RSpec.configure do |c|
        c.stdout = "#{value}\n"
      end
    end

    context linux_kernel_parameter(param) do
      its(:value) { should eq value }
    end

    context linux_kernel_parameter(param) do
      its(:value) { should_not eq value + 1 }
    end
  end
end

shared_examples_for 'support explicit linux kernel parameter checking with string' do |param, value|
  describe 'linux kernel parameter' do
    before :all do
      RSpec.configure do |c|
        c.stdout = "#{value}\n"
      end
    end

    context linux_kernel_parameter(param) do
      its(:value) { should eq value }
    end

    context linux_kernel_parameter(param) do
      its(:value) { should_not eq value + '_suffix' }
    end
  end
end

shared_examples_for 'support explicit linux kernel parameter checking with regexp' do |param, regexp|
  describe 'linux kernel parameter' do
    before :all do
      RSpec.configure do |c|
        c.stdout = "4096	16384	4194304\n"
      end
    end

    context linux_kernel_parameter(param) do
      its(:value) { should match regexp }
    end

    context linux_kernel_parameter(param) do
      its(:value) { should_not match /invalid-string/ }
    end
  end
end
