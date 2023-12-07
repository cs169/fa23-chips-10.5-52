require 'rails_helper'

RSpec.describe UserController, type: :controller do
  describe "GET #profile" do
    let(:user) { create(:user) } # Assuming you have a user factory

    context "when a user is logged in" do
      before do
        session[:current_user_id] = user.id
        get :profile
      end

      it "finds the user from session and assigns to @user" do
        expect(assigns(:user)).to eq(user)
      end

      it "renders the profile template" do
        expect(response).to render_template(:profile)
      end
    end

    context "when no user is logged in" do
      before { get :profile }

      it "does not assign @user" do
        expect(assigns(:user)).to be_nil
      end

      # Add additional expectations here, such as redirection to a login page
    end
  end
end
