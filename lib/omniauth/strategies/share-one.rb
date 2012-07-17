require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class ShareOne < OmniAuth::Strategies::OAuth2
      option :name, 'share-one'
      option :client_options, {
        :site => 'https://emery-md.nssecurebanking.org',
        :authorize_url => '/oauth/authorize',
        :token_url => '/oauth/token'
      }

      def authorize_params
        super.tap do |params|
          params[:response_type] = "code"
          params[:client_id] = client.id
          params[:redirect_url] ||= callback_url
        end
      end

      def request_phase
        super
      end

      def build_access_token
        token_params = {
          :code => request.params['code'],
          :redirect_url => callback_url,
          :client_id => client.id,
          :grant_type => 'authorization_code'
        }
        client.get_token(token_params)
      end
    end
  end
end
