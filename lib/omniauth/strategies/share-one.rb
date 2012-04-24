require 'omniauth-oauth'
require 'multi_json'

module OmniAuth
  module Strategies
    class ShareOne < OmniAuth::Strategies::OAuth
      option :name, 'share-one'
      option :client_options, {:authorize_path => '/oauth/authorize',
                               :site => 'https://emery-md.nssecurebanking.org'}

      uid { access_token.params[:user_id] }

      info do
        {
          :nickname => raw_info['screen_name'],
          :name => raw_info['name'],
          :location => raw_info['location'],
          :image => raw_info['profile_image_url'],
          :description => raw_info['description'],
          :urls => {
            'Website' => raw_info['url'],
            'ShareOne' => 'http://share-one.com/' + raw_info['screen_name'],
          }
        }
      end

      extra do
        { :raw_info => raw_info }
      end

      def raw_info
        @raw_info ||= MultiJson.load(access_token.get('/api/v1/accounts').body)
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end

      alias :old_request_phase :request_phase

      def request_phase
        screen_name = session['omniauth.params'] ? session['omniauth.params']['screen_name'] : nil
        if screen_name && !screen_name.empty?
          options[:authorize_params] ||= {}
          options[:authorize_params].merge!(:force_login => 'true', :screen_name => screen_name)
        end
        old_request_phase
      end
    end
  end
end