class User < ActiveRecord::Base
  has_many :tasks

  has_secure_password

  validates :username, presence: true, uniqueness: true, length: { minimum: 4 }
  validates :password, length: { minimum: 6 }
end