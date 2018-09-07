require 'rails_helper'

describe HomeController, type: :controller do
  # before do
  #   params[:hands] = "S8 S7 S6 S5 S12"
  # end
  describe 'Get #top' do
    before do
      get :top
    end
    it 'リクエストは200 OKとなること' do
      expect(response.status).to eq 200
    end
    it ':topテンプレートを表示すること' do
      expect(response).to render_template :top
    end
  end

  describe 'Post #check' do
    before do

    end
    it 'リクエストは200 OKとなること' do
      expect(response.status).to eq 200
    end


    context 'バリデーションが通った場合' do

      it 'フラッシュ判定' do
        # @hand = Hand.new(content: hands)
        # @hand.valid? == true
        post :check, params: {hands: "S8 S7 S6 S5 S1"}
        answer = controller.instance_variable_get("@answers")[0][:answer]
        expect(answer).to eq "フラッシュ"
      end
    end


  end
end