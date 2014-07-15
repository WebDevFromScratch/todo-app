class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates :name, presence: true, uniqueness: true
  validates :category, presence: true
  validates :priority, presence: true

  def priority_to_word
    if self.priority == 1
      'Low'
    elsif self.priority == 2
      'Medium'
    elsif self.priority == 3
      'High'
    else
      'WTF' #this should be removed later on
    end
  end
end