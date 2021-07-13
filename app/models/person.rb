class Person < ApplicationRecord
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
	validates :phone, format: { with:  /\d[0-9]\)*\z/ }
end
