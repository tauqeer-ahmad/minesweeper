class User < ApplicationRecord
  has_many :boards
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, uniqueness: true
end
