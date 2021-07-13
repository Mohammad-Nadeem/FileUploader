class TemporaryPerson < ApplicationRecord

    after_commit :validate_and_create_person
  
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    failed_record = []
    (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    tperson = TemporaryPerson.new
    tperson.attributes = row.to_hash.slice(*row.to_hash.keys)
    tperson.save!
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

  private

  def validate_and_create_person
    person = Person.new
    person.attributes = self.attributes.slice('first_name', 'last_name', 'email', 'phone')
    if person.save
      self.update_column(:processed, true)
    else
      self.update_column(:validation_errors, person.errors.full_messages.join(', '))
    end

  end

end
