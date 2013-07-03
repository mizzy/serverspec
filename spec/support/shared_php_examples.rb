shared_examples_for 'support php match_ini_value matcher' do |name, value|
  describe 'match_ini_value' do
    describe php(name) do
      it { should match_ini_value value }
    end

    describe php('memory_limit') do
      it { should_not match_ini_value '0M' }
    end
  end
end
