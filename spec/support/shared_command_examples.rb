shared_examples_for 'support command return_stdout matcher' do |name, content|
  describe 'return_stdout' do
    describe command(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "#{content}\r\n"
        end
      end
      it { should return_stdout(content) }
    end

    describe command(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "foo#{content}bar\r\n"
        end
      end
      it { should_not return_stdout(content) }
    end


    describe command('invalid-command') do
      it { should_not return_stdout(content) }
    end
  end
end

shared_examples_for 'support command return_stdout matcher with regexp' do |name, content|
  describe 'return_stdout' do
    describe command(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "foo#{content}bar\r\n"
        end
      end
      it { should return_stdout(content) }
    end

    describe command(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "foobar\r\n"
        end
      end
      it { should_not return_stdout(content) }
    end

    describe command('invalid-command') do
      it { should_not return_stdout(content) }
    end
  end
end

shared_examples_for 'support command return_stderr matcher' do |name, content|
  describe 'return_stderr' do
    describe command(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "#{content}\r\n"
        end
      end
      it { should return_stderr(content) }
    end

    describe command(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "No such file or directory\r\n"
        end
      end
      it { should_not return_stderr(content) }
    end
  end
end

shared_examples_for 'support command return_stderr matcher with regexp' do |name, content|
  describe 'return_stderr' do
    describe command(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "cat: /foo: No such file or directory\r\n"
        end
      end
      it { should return_stdout(content) }
    end

    describe command(name) do
      before :all do
        RSpec.configure do |c|
          c.stdout = "foobar\r\n"
        end
      end
      it { should_not return_stdout(content) }
    end
  end
end

shared_examples_for 'support command return_exit_status matcher' do |name, status|
  describe 'return_exit_status' do
    describe command(name) do
      it { should return_exit_status(status) }
    end

    describe command('invalid-command') do
      it { should_not return_exit_status(status) }
    end
  end
end
