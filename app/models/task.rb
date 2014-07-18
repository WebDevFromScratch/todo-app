class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates :name, presence: true, uniqueness: true
  validates :category, presence: true
  validates :priority, presence: true

  validate :deadline_cannot_be_in_the_past

  def deadline_cannot_be_in_the_past
    errors.add(:deadline, "cannot be in the past") if !deadline.blank? && deadline < Date.today
  end

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

  def mark_accomplished
    self.accomplished = true
  end
end