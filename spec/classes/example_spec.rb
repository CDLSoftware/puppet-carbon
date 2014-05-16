require 'spec_helper'

describe 'carbon' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "carbon class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('carbon::params') }
        it { should contain_class('carbon::install').that_comes_before('carbon::config') }
        it { should contain_class('carbon::config') }
        it { should contain_class('carbon::service').that_subscribes_to('carbon::config') }

        it { should contain_service('carbon') }
        it { should contain_package('carbon').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'carbon class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('carbon') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
