shared_examples_for 'support explicit php_config checking with integer' do |param, value|
  describe 'php config' do
    before :all do
      RSpec.configure do |c|
        c.stdout = "#{value}"
      end
    end

    context php_config(param) do
      its(:value) { should eq value }
    end

    context php_config(param) do
      its(:value) { should_not eq value + 1 }
    end
  end
end

shared_examples_for 'support explicit php_config checking with string' do |param, value|
  describe 'php config' do
    before :all do
      RSpec.configure do |c|
        c.stdout = "#{value}"
      end
    end

    context php_config(param) do
      its(:value) { should eq value }
    end

    context php_config(param) do
      its(:value) { should_not eq value + '_suffix' }
    end
  end
end

shared_examples_for 'support explicit php_config checking with regexp' do |param, regexp|
  describe 'php config' do
    before :all do
      RSpec.configure do |c|
        c.stdout = "application"
      end
    end

    context php_config(param) do
      its(:value) { should match regexp }
    end

    context php_config(param) do
      its(:value) { should_not match /invalid-string/ }
    end
  end
end
