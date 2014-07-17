class User < ActiveRecord::Base
  has_many :tasks

  has_secure_password # default validations were left (auto confirm validation)

  validates :username, presence: true, uniqueness: true, length: { minimum: 4 }
  validates :password, length: { minimum: 6 }, on: :create

  before_save :generate_slug

  def to_param
    self.slug
  end

  def generate_slug
    the_slug = to_slug(self.username)
    user = User.find_by slug: the_slug
    count = 1
    while user && user != self #to ensure not falling into eternal loop
      the_slug = apppend_suffix(the_slug) #the_slug + '-' + count.to_s
      user = User.find_by slug: the_slug
      count += 1
    end
    
    self.slug = the_slug
  end

  def append_suffix(str, count)
    if str.split('-').last.to_i != 0
      str.split('-').slice(0...-1).join('-') + "-" + count.to_s
    else
      str + '-' + count.to_s
    end
  end

  def to_slug(name)
    str = name.split
    str.each { |word| word.gsub! /\W/, '' }
    str = str.join('-')
    str.gsub! /-+/, '-'
    while str.end_with?('-')
      str.chop!
    end
    str.downcase #be sure to return the string at the end
  end
end