class Contact < ActiveRecord::Base

  #validates [:name, :tos], :presence => true
  validates_presence_of :name, :tos
  #validates_acceptance_of :tos
  validates_confirmation_of :email
  validates_length_of :name, { minimum: 2, maximum: 500 }
  validates_length_of :lastname, {in: 6..20}
  validates_length_of :phone, {is: 12}
  validates :email, :presence => true, uniqueness: true, :format => {:with => /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i}

end
