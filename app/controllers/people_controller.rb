class PeopleController < ApplicationController
  def index
  	@people = Person.all
  end

  def upload_csv
    Person.import(params[:csv])
    redirect_to root_url, notice: "People imported successfully."		
  end
end
