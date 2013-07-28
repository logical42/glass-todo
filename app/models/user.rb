class User < ActiveRecord::Base

  has_one :google_account

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,         :registerable,              :recoverable, 
         :rememberable,                     :trackable,                 :validatable,
         :omniauthable,                     omniauth_providers: [:google_oauth2]
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    access_token.with_indifferent_access
    info = access_token[:info]
    user = User.where(email: info[:email]).first
    google_account = GoogleAccount.where(email: info[:email]).first
    if google_account and google_account.user
      user = google_account.user
    end
    unless user
      user = User.create(name: info[:name],
                         email: info[:email],
                         password: Devise.friendly_token[0,20])
    end
    user.find_or_create_google_account_from_access_token(access_token)
    user
  end
  def find_or_create_google_account_from_access_token(access_token)
    return self.google_account if self.google_account
    ga = GoogleAccount.where(user_id: self.id).first_or_initialize
    data_hash = access_token[:credentials]
    data_hash.merge!(access_token[:info])
    [:token, :refresh_token, :expires_at, :name, :email].each do |attribute|
      ga.send("#{attribute}=", data_hash[attribute]) if data_hash[attribute]
    end
    ga.save
    ga
  end
end
