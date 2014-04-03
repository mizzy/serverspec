require 'spec_helper'

describe Serverspec::Type::Command do
  subject { command('echo banana') }

  before :each do
    allow(subject.backend).to receive(:run_command).and_return(
        CommandResult.new({
          :stdout      => "banana\n",
          :stderr      => "split\n",
          :exit_status => "42",         # Command should convert this to an integer
        })
    )
  end

  it 'has stdout' do
    expect(subject.stdout).to be == "banana\n"
  end

  it 'has stderr' do
    expect(subject.stderr).to be == "split\n"
  end

  it 'has exit_status' do
    expect(subject.exit_status).to be == 42
  end

  it 'does not conflate stdout and stderr' do
    expect(subject.stdout).to eq("banana\n")
    expect(subject.stderr).to eq("split\n")
  end

  it 'runs the command lazily' do
    expect(subject.backend).to receive(:run_command).exactly(0).times

    # Not sending any messages to the subject.
  end

  it 'does not run the command more than once' do
    expect(subject.backend).to receive(:run_command).once

    # We can send all these messages, but the command is invoked only once.
    subject.stdout
    subject.stderr
    subject.exit_status
    subject.return_stdout? 'foo'
    subject.return_stderr? 'foo'
    subject.return_exit_status? 0
  end

  describe '#return_stdout?' do
    it 'matches against a string, stripping whitespace' do
      expect(subject.return_stdout? 'banana').to be_true
      expect(subject.return_stdout? 'pancake').to be_false
    end

    it 'matches against a regex' do
      expect(subject.return_stdout? /anan/).to be_true
      expect(subject.return_stdout? /^anan/).to be_false
    end
  end

  describe '#return_stderr?' do
    it 'matches against a string, stripping whitespace' do
      expect(subject.return_stderr? 'split').to be_true
      expect(subject.return_stderr? 'pancake').to be_false
    end

    it 'matches against a regex' do
      expect(subject.return_stderr? /pli/).to be_true
      expect(subject.return_stderr? /^pli/).to be_false
    end
  end

  describe '#return_stderr?' do
    it 'matches against an integer' do
      expect(subject.return_exit_status? 42).to be_true
      expect(subject.return_exit_status? 43).to be_false
    end
  end
end
