require 'rails_helper'

RSpec.describe "Contacts", type: :request do

  context 'unauthenticated access' do
    it 'root page is accessible' do
      get root_path

      expect(response).to           be_successful
      expect(response).to           have_http_status(200)
      expect(response.body).to      match "<p hidden id='root' class='pageName'></p>"
    end
  end

end
