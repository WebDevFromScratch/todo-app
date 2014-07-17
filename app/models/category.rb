class Category < ActiveRecord::Base
  has_many :tasks
  has_many :user_categories
  has_many :users, through: :user_categories

  validates :name, presence: true, uniqueness: true, length: { minimum: 4 }
end