require 'spec_helper'

describe OmniAuth::Strategies::ShareOne do
  subject do
    OmniAuth::Strategies::ShareOne.new({})
  end

  context "client options" do
    it 'should have correct name' do
      subject.options.name.should eq("share-one")
    end

    it 'should have correct site' do
      subject.options.client_options.site.should eq('https://emery-md.nssecurebanking.org')
    end

    it 'should have correct authorize url' do
      subject.options.client_options.authorize_url.should eq('/oauth/authorize')
    end
  end
end
