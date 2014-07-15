class User < ActiveRecord::Base
  has_many :tasks

  has_secure_password # default validations were left (auto confirm validation)

  validates :username, presence: true, uniqueness: true, length: { minimum: 4 }
  validates :password, length: { minimum: 6 }, on: :create
end