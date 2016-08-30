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

  def name
    "#{first_name} #{last_name}"
  end

  def self.create_with_omniauth(info)
    create(first_name: info.extra.raw_info.first_name,
           last_name:  info.extra.raw_info.last_name,
           email:      info.email || "#{info.uid}@#{info.provider}.com")
  end
end
