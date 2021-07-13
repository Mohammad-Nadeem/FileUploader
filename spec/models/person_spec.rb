require 'rails_helper'

RSpec.describe Person, :type => :model do
  describe "Person data validations" do
    let(:person_1) { Person.new(first_name: 'first', last_name: 'last', email: 'test@example.com', phone: '+123456789') }

    it "first_name and last_name is required" do
      person_1.first_name = ''
      person_1.last_name = ''
      person_1.valid?
      expect(person_1.errors.full_messages).to include("First name can't be blank", "Last name can't be blank")
    end

    it "email format validation" do
      person_1.email = 'abc@com'
      person_1.valid?
      expect(person_1.errors.full_messages).to eq(["Email is invalid"])
    end

    it "phone format validation" do
      person_1.phone = '1234A'
      person_1.valid?
      expect(person_1.errors.full_messages).to eq(["Phone is invalid"])
    end
  end
end