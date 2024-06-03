module RedirectionWithToken
    extend ActiveSupport::Concern
  
    included do
      alias_method :original_redirect_to, :redirect_to
  
      def redirect_to(options = {}, response_options = {})
        token = current_user&.auth_token || "default-token"
        response_options[:headers] ||= {}
        response_options[:headers]['Authorization'] = "Bearer #{token}"
        original_redirect_to(options, response_options)
      end
    end
  end
  