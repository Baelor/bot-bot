require 'sequel'
require 'securerandom'

# DB model for bots
class Bots < Sequel::Model
  plugin :secure_password, include_validations: false

  # Stolen from devise.
  # Generate a friendly string randomly to be used as token.
  # By default, length is 12 characters.
  def self.friendly_token(length = 20)
    # To calculate real characters, we must perform this operation.
    # See SecureRandom.urlsafe_base64
    rlength = (length * 3) / 4
    SecureRandom.urlsafe_base64(rlength).tr('lIO0', 'sxyz')
  end
end
