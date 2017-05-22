require 'fileutils'
require 'spec_helper'
require 'tmpdir'

describe "setup environment" do
  SCRATCH_DIR = Dir.tmpdir() + '/' + "rspec_dir"

  before(:all) do
    FileUtils.remove_dir SCRATCH_DIR, :force => true
    FileUtils.mkdir SCRATCH_DIR
  end

  after(:all) do
    FileUtils.remove_dir SCRATCH_DIR, :force => true
  end

  describe "sample_spec.rb" do
    SAMPLE_SPEC_FILE = SCRATCH_DIR + '/sample_spec.rb'

    it "creates it if it does not exist" do
      ret_val = Serverspec::Setup.safe_create_spec SAMPLE_SPEC_FILE
      expect(ret_val).to eq true
      expect(File.exists? SAMPLE_SPEC_FILE).to be true
    end

    it "skips creation if the file exists with identical content" do
      ret_val = Serverspec::Setup.safe_create_spec SAMPLE_SPEC_FILE
      expect(ret_val).to eq true

      ret_val = Serverspec::Setup.safe_create_spec SAMPLE_SPEC_FILE
      expect(ret_val).to eq true

      expect(File.exists? SAMPLE_SPEC_FILE).to be true
    end

    it "aborts if a file exists with different content" do
      File.open(SAMPLE_SPEC_FILE, 'w') do |f|
        f.puts 'hi'
      end
      old_content = File.read SAMPLE_SPEC_FILE

      ret_val = Serverspec::Setup.safe_create_spec SAMPLE_SPEC_FILE
      expect(ret_val).to eq false

      new_content = File.read(SAMPLE_SPEC_FILE)
      expect(old_content).to eq new_content
    end
  end

  describe "spec_helper.rb" do
    SPEC_HELPER_FILE = SCRATCH_DIR + '/spec_helper.rb'

    it "creates it if it does not exist" do
      ret_val = Serverspec::Setup.safe_create_spec_helper SPEC_HELPER_FILE
      expect(ret_val).to eq true
      expect(File.exists? SPEC_HELPER_FILE).to be true
    end

    it "skips creation if the file exists with identical content" do
      ret_val = Serverspec::Setup.safe_create_spec_helper SPEC_HELPER_FILE
      expect(ret_val).to eq true

      ret_val = Serverspec::Setup.safe_create_spec_helper SPEC_HELPER_FILE
      expect(ret_val).to eq true

      expect(File.exists? SPEC_HELPER_FILE).to be true
    end

    it "aborts if a file exists with different content" do
      File.open(SPEC_HELPER_FILE, 'w') do |f|
        f.puts 'hi'
      end
      old_content = File.read SPEC_HELPER_FILE

      ret_val = Serverspec::Setup.safe_create_spec_helper SPEC_HELPER_FILE
      expect(ret_val).to eq false

      new_content = File.read(SPEC_HELPER_FILE)
      expect(old_content).to eq new_content
    end
  end

  describe "rakefile.rb" do
    RAKEFILE = SCRATCH_DIR + '/Rakefile'

    it "creates it if it does not exist" do
      ret_val = Serverspec::Setup.safe_create_rakefile RAKEFILE
      expect(ret_val).to eq true
      expect(File.exists? RAKEFILE).to be true
    end

    it "skips creation if the file exists with identical content" do
      ret_val = Serverspec::Setup.safe_create_rakefile RAKEFILE
      expect(ret_val).to eq true

      ret_val = Serverspec::Setup.safe_create_rakefile RAKEFILE
      expect(ret_val).to eq true

      expect(File.exists? RAKEFILE).to be true
    end

    it "aborts if a file exists with different content" do
      File.open(RAKEFILE, 'w') do |f|
        f.puts 'hi'
      end
      old_content = File.read RAKEFILE

      ret_val = Serverspec::Setup.safe_create_rakefile RAKEFILE
      expect(ret_val).to eq false

      new_content = File.read(RAKEFILE)
      expect(old_content).to eq new_content
    end
  end

  describe ".rspec" do
    DOTRSPEC = SCRATCH_DIR + '/.rspec'

    it "creates it if it does not exist" do
      ret_val = Serverspec::Setup.safe_create_dotrspec DOTRSPEC
      expect(ret_val).to eq true
      expect(File.exists? DOTRSPEC).to be true
    end

    it "skips creation if the file exists with identical content" do
      ret_val = Serverspec::Setup.safe_create_dotrspec DOTRSPEC
      expect(ret_val).to eq true

      ret_val = Serverspec::Setup.safe_create_dotrspec DOTRSPEC
      expect(ret_val).to eq true

      expect(File.exists? DOTRSPEC).to be true
    end

    it "aborts if a file exists with different content" do
      File.open(DOTRSPEC, 'w') do |f|
        f.puts 'hi'
      end
      old_content = File.read DOTRSPEC

      ret_val = Serverspec::Setup.safe_create_dotrspec DOTRSPEC
      expect(ret_val).to eq false

      new_content = File.read(DOTRSPEC)
      expect(old_content).to eq new_content
    end
  end
end
