require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
   it "renders the new template" do
     get :new, {}
     expect(response).to render_template("new")
   end
 end

 describe "POST #create" do
  context "with invalid params" do
     it "validates the presence of the user's email and password"do
       post :create, params: {user: {password: '123456'}}
       expect(flash[:errors]).to be_present
       expect(response).to render_template('new')
     end
     it "validates that the password is at least 6 characters long" do
       post :create, params:{user: {email: 'alkmdsfm', password: '123'}}
       expect(flash[:errors]).to be_present
       expect(response).to render_template('new') 
     end
   end
   
   # context "with valid params" do
   #   it "redirects user to bands index on success"
   # 
   # end
 
 end
end
