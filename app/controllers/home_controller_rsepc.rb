require 'rails_helper'

describe HomeController, type: :controller do
  describe 'GET #top' do
    it "render the :top template" do
      get :top
      expect(response).to render_template :top
    end
  end
end