require 'spec_helper'
describe 'puppet_config', type: 'class' do
  let :facts do
    {
      puppet_confdir: '/etc/puppetlabs/puppet',
      architecture: 'x86_64',
      osfamily: 'RedHat',
      os: {
        'name' => 'CentOS',
        'family' => 'RedHat',
        'release' => {
          'major' => '7',
          'minor' => '7',
          'full'  => '7.7.1908'
        }
      }
    }
  end

  context 'with defaults for all parameters' do
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('puppet_config') }
  end

  %w[emerg crit alert err warning notice info debug verbose].each do |loglevel|
    context "with loglevel #{loglevel}" do
      let :params do {
        main: { 'loglevel' => loglevel }
      } end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('puppet_config') }
      it { is_expected.to contain_puppet_config__config_block('main') }
      it { is_expected.to contain_puppet_config__inisetting('main loglevel').with_value(loglevel) }
    end
  end

  context 'with array input' do
    let :params do {
      main: { loglevel: ['warn'] }
    } end

    it { is_expected.to compile.and_raise_error(%r{expects a value of type Undef or String, got Tuple}) }
  end
end
