require 'spec_helper_acceptance'

describe 'puppet_config class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'installs with no errors using default values' do
      puppetagent = <<-EOS
        class { ['puppet_agent','puppet_config']: }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(puppetagent, catch_failures: true)
      apply_manifest(puppetagent, catch_changes: true)
    end

    describe file('/etc/puppetlabs/puppet/puppet.conf') do
      it { is_expected.to be_a_file }
    end
  end
end
