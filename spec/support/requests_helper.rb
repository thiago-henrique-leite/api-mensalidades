module RequestsHelper
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def setup_basic_auth(user, password)
      let(:authorization_header) { { HTTP_AUTHORIZATION: ActionController::HttpAuthentication::Basic.encode_credentials(user, password) } }
    end
  end
end
