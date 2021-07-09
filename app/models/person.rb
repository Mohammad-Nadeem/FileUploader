class Person < ApplicationRecord
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
	validates :phone, format: { with:  /\d[0-9]\)*\z/ }

	COLUMNS_TO_STRING = ["first_name", "last_name", "email", "phone"]

	def self.import(file)
	  spreadsheet = open_spreadsheet(file)
	  header = spreadsheet.row(1)
	  (2..spreadsheet.last_row).each do |i|
	  row = Hash[[header, spreadsheet.row(i)].transpose]
	  person = Person.new
	  person.attributes = row.to_hash.slice(*row.to_hash.keys)
	  person.save!
	 end
	end

	def self.open_spreadsheet(file)
	  case File.extname(file.original_filename)
	  when ".csv" then Roo::CSV.new(file.path)
	  when ".xls" then Roo::Excel.new(file.path)
	  when ".xlsx" then Roo::Excelx.new(file.path)
	  else raise "Unknown file type: #{file.original_filename}"
	  end
	end
end
