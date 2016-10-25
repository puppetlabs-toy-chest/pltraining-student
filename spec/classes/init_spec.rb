require "spec_helper"

describe "student" do
  let(:node) { 'test.example.com' }

  let(:facts) { {
    :operatingsystemrelease    => "6.8",
    :operatingsystemmajrelease => "6",
    :osfamily                  => "RedHat",
    :operatingsystem           => "CentOS",
    :architecture              => "i386",
    :os => {
      :family => 'RedHat',
      :release => {
        :major => '6',
        :minor => '8',
      }
    },
  } }

  it { is_expected.to compile.with_all_deps }

end
