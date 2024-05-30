class User < ApplicationRecord
  has_secure_password
  validate :password_complexity, if: -> { new_record? || password.present? }
  has_many :tasks
#   mount_uploader :avatar, AvatarUploader
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 8 },
            if: -> { new_record? || !password.nil? }
end

private

  def password_complexity
    unless password.match?(/(?=.*[A-Z])(?=.*[!@#$%^&*])(?=.*[0-9])/)
      errors.add(:password, "must include at least one uppercase letter, one special character, and one number")
    end
  end