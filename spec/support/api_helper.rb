module ApiHelper
  def authenticated_header(user)
    token = JsonWebToken.encode(user_id: user.id)
    headers = {'Authorization': "Bearer #{token}"}
    return headers
  end
end


RSpec.configure do |config|
  config.include ApiHelper
end
