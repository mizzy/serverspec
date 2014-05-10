shared_examples "a powershell command runner" do
  describe 'configurations are not set' do
    context file('/some/file') do
      it { should be_file }
      its(:command) { should == "((Get-Item -Path '/some/file' -Force).attributes.ToString() -Split ', ') -contains 'Archive'" }
    end
  end

  describe 'path is set' do
    let(:path) { 'c:/path/bin' }
    context file('/some/file') do
      it { should be_file }
      its(:command) { 
        should == <<-eof
$env:path = "c:/path/bin;$env:path"
((Get-Item -Path '/some/file' -Force).attributes.ToString() -Split ', ') -contains 'Archive'
eof
      }
    end
  end

  describe 'pre_command is set' do
    let(:pre_command) { 'some_other_command' }
    context file('/some/file') do
      it { should be_file }
      its(:command) { should == <<-eof
if (some_other_command)
{
((Get-Item -Path '/some/file' -Force).attributes.ToString() -Split ', ') -contains 'Archive'
}
eof
      }
    end
  end

  describe 'path and pre_command are set' do
    let(:path) { 'c:/path/bin' }
    let(:pre_command) { 'some_other_command' }
    context file('/some/file') do
      it { should be_file }
      its(:command) { should == <<-eof
$env:path = "c:/path/bin;$env:path"
if (some_other_command)
{
$env:path = "c:/path/bin;$env:path"
((Get-Item -Path '/some/file' -Force).attributes.ToString() -Split ', ') -contains 'Archive'
}
eof
      }
    end
  end
end