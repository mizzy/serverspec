shared_examples_for 'support interface matcher' do |name|
  describe 'interface' do
    before :all do
      RSpec.configure do |c|
        c.stdout = "1000"
      end
    end

    describe interface(name) do
      its(:speed) { should eq 1000 }
    end

    describe interface('invalid-interface') do
      its(:speed) { should_not eq 100 }
    end
  end
end
