require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "GET #home" do
    context "when logged out" do
      it "returns 200" do
        get :home
        expect(response).to have_http_status(:success)
      end
    end
  end

end
