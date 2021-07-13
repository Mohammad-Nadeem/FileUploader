class PeopleController < ApplicationController
  def index
    @people = Person.all
    @failed_records = TemporaryPerson.where(processed: false)
  end

  def upload_csv
    TemporaryPerson.import(params[:csv])
    redirect_to root_url, notice: "People imported successfully."   
  end

  def resave_person
    @temp_person = TemporaryPerson.find_by(id: params[:tid])
    @temp_person.attributes = resave_params
    @temp_person.save
    @failed_records = TemporaryPerson.where(processed: false)
    respond_to do |format|
      format.js
    end
  end

  private

  def resave_params
    params.require(:temporary_person).permit(:first_name, :last_name, :email, :phone)
    
  end
end
