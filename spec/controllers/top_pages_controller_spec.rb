require 'rails_helper'

RSpec.describe TopPagesController, type: :controller do

  describe "GET #home" do
    
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end
    
    it "returns a 200 response" do
      get :home
      expect(response).to have_http_status(200)
    end
  end

end
