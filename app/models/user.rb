class User < ApplicationRecord
  has_many :identities, dependent: :destroy

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :lockable,
         :confirmable,
         :omniauthable

  def self.from_omniauth(auth, current_user)
    identity = Identity.where(
      provider: auth.provider,
      uid: auth.uid.to_s,
      token: auth.credentials.token,
      secret: auth.credentials.secret
    ).first_or_initialize

    if identity.user.blank?
      user = current_user || User.where(email: auth.info.email).first
      if user.blank?
        user = User.new
        user.skip_confirmation!
        user.password = Devise.friendly_token[0, 20]
        user.fetch_details(auth)
        user.save
      end
      identity.user = user
      identity.save
    end
    identity.user
  end

  def fetch_details(auth)
    self.name = auth.info.name
    self.email = auth.info.email
    parse_location(auth.info.location)
  end

  def parse_location(location_string)
    return if location_string.nil?
    location = location_string.split(", ")
    unless location.nil?
      self.country = location[0] || ""
      self.city = location[1] || ""
    end
  end
end
