class User < ApplicationRecord
  before_validation :downcase_email

  validates :name, presence: true
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format:     { with: URI::MailTo::EMAIL_REGEXP }

  after_create_commit :send_welcome_email

  private

  def send_welcome_email
    NotificationMailer.welcome_email(@user).deliver_later
  end

  def downcase_email
    self.email = email.to_s.downcase
  end
end
