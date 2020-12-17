class LoginController < ApplicationController
  def create
    user = User.find_by(name: params[:name])
    if user&.authenticate(params[:password])

      payload = { user_id: user.id }
      refresh_payload = { user_id: user.id }
      session = JWTSessions::Session.new(payload: payload, refresh_payload: refresh_payload)
      tokens = session.login
      response.set_cookie(JWTSessions.refresh_cookie,
                          value: tokens[:refresh],
                          httponly: true,
                          secure: Rails.env.production?)

      render json: { tokens: tokens }
    else
      render json: "Cannot login", status: :unauthorized
    end
  end
end
