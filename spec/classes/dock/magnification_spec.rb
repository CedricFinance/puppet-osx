require 'spec_helper'

describe 'osx::dock::magnification' do
  let(:facts) { {:boxen_user => 'ilikebees'} }

  it do
    should include_class('osx::dock')
    should contain_boxen__osx_defaults('magnification').with_value(true)
    should contain_boxen__osx_defaults('magnification_size').with_value(128)
  end

  describe 'with parameters' do

    describe 'disable' do
      let(:params) { {:magnification => false } }
      
      it do
        should include_class('osx::dock')

        should contain_boxen__osx_defaults('magnification').with({
          :key    => 'magnification',
          :domain => 'com.apple.dock',
          :type   => 'bool',
          :value  => false,
          :user   => facts[:boxen_user],
          :notify => 'Exec[killall Dock]'
        })

        should_not contain_boxen__osx_defaults('magnification_size').with({
          :key    => 'largesize',
          :domain => 'com.apple.dock',
          :type   => 'int',
          :value  => 128,
          :user   => facts[:boxen_user],
          :notify => 'Exec[killall Dock]'
        })
      end
    end

    describe 'change size' do
      let(:params) { {:magnification_size => 16} }
      it do
        should include_class('osx::dock')

        should contain_boxen__osx_defaults('magnification').with({
          :key    => 'magnification',
          :domain => 'com.apple.dock',
          :type   => 'bool',
          :value  => true,
          :user   => facts[:boxen_user],
          :notify => 'Exec[killall Dock]'
        })

        should contain_boxen__osx_defaults('magnification_size').with({
          :key    => 'largesize',
          :domain => 'com.apple.dock',
          :type   => 'int',
          :value  => 16,
          :user   => facts[:boxen_user]
        })
      end
    end

  end
end
