shared_examples_for 'support php_config match_ini_value matcher' do |name, value|
  describe 'match_ini_value' do
    describe php_config(name) do
      it { should match_ini_value value }
    end

    describe php_config('memory_limit') do
      it { should match_ini_value '0M' }
    end
  end
end
