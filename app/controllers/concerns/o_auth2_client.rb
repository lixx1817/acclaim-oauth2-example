module OAuth2Client
  extend ActiveSupport::Concern

  included do
   def return_access_token()
     @token = session["token"]
     client ||= OAuth2::Client.new(ENV["ACCLAIM_ID"], ENV["ACCLAIM_SECRET"], :site => "https://jefferson-staging.herokuapp.com")
     @access_token ||= OAuth2::AccessToken.new(client, @token)
   end
  end
end