class CallbacksController < Devise::OmniauthCallbacksController

  def vkontakte
    abstract_callback
  end

  def facebook
    abstract_callback
  end

  private

  def abstract_callback
    user = User.from_omniauth(env['omniauth.auth'], current_user)
    if user.persisted?
      sign_in_and_redirect user
    else
      session['devise.user_attributes'] = user.attributes
      redirect_to new_user_registration_url
    end
  end
end
