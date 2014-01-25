class Contact < ActiveRecord::Base

  validates :name, :presence => true
  validates :email, :presence => true, uniqueness: true, :format => {:with => /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i}

end
