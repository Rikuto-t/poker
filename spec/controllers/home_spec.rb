require 'rails_helper'

describe HomeController, type: :controller do
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

    it 'リクエストは200 OKとなること' do
      expect(response.status).to eq 200
    end

    context 'エラーが出る時' do
      describe '再読み込みした時'
      it 'rootにリダイレクトすること' do
        get :check
        expect(response).to redirect_to root_path
      end
      describe '不正な値がpostされた時'
      it ':topテンプレートを表示すること' do
        post :check, params: {hands: ""}
        expect(response).to render_template :top
      end
    end

    context 'エラーが出ない時' do
      it '有効な値がpostされた時' do
        post :check, params: {hands: "S8 S7 S6 S5 S1"}
        expect(controller.instance_variable_get("@answers")[0][:answer]).to eq "フラッシュ"
      end
    end
  end
end