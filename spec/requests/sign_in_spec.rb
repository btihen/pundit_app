require 'rails_helper'

RSpec.describe "SignIn Page", type: :request do

  context 'user not registered' do
    it 'can access login page' do
      get new_user_session_path

      expect(response).to           be_successful
      expect(response).to           have_http_status(200)
      expect(response.body).to      match "<p hidden id='login' class='pageName'></p>"
    end
  end

end
