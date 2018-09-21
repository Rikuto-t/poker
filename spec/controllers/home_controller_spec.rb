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
    context 'エラーになる時' do
      context '不正な値がpostされた時' do
        context '空白がpostされた時' do
          before do
            post :check, params: {hands: ''}
          end
          it ':topテンプレートを表示すること' do
            expect(response).to render_template :top
          end
          it '期待されるエラーメッセージが取得できること' do
            expect(assigns(:error_messages)[0]).to eq '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11)'
          end
        end
        context '重複するカードがpostされたとき' do
          before do
            post :check, params: {hands: 'S8 S7 S6 S5 S5'}
          end
          it ':topテンプレートを表示すること' do
            expect(response).to render_template :top
          end
          it '期待されるエラーメッセージが取得できること' do
            expect(assigns(:error_messages)[0]).to eq '同じカードが入力されています'
          end
        end
        context 'カードが5枚入力されていない時' do
          before do
            post :check, params: {hands: 'S8 S7 S6 S5'}
          end
          it ':topテンプレートを表示すること' do
            expect(response).to render_template :top
          end
          it '期待されるエラーメッセージが取得できること' do
            expect(assigns(:error_messages)[0]).to eq '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11)'
          end
        end
        context 'カードの正しい値が入力されていない時' do
          before do
            post :check, params: {hands: 'S8 S7 S6 S5adf fads'}
          end
          it ':topテンプレートを表示すること' do
            expect(response).to render_template :top
          end
          it '期待されるエラーメッセージが取得できること' do
            expect(assigns(:error_messages)[0]).to eq '4番目のカード文字が不正です (S5adf)'
            expect(assigns(:error_messages)[1]).to eq '5番目のカード文字が不正です (fads)'
          end
        end
      end
    end

    context 'エラーにならない時' do
      context 'ストレートフラッシュ役がpostされた時' do
        before do
          post :check, params: {hands: 'C7 C6 C5 C4 C3'}
        end
        it ':checkテンプレートを表示すること' do
          expect(response).to render_template :check
        end
        it 'ストレートフラッシュがインスタンス変数に代入されること' do
          expect(assigns(:answer)[:answer]).to eq 'ストレートフラッシュ'
        end
      end
      context '4カード役がpostされた時' do
        before do
          post :check, params: {hands: 'D6 H6 S6 C6 S13'}
        end
        it ':checkテンプレートを表示すること' do
          expect(response).to render_template :check
        end
        it '4カードがインスタンス変数に代入されること' do
          expect(assigns(:answer)[:answer]).to eq '4カード'
        end
      end
      context 'フルハウス役がpostされた時' do
        before do
          post :check, params: {hands: 'H9 C9 S9 H1 C1'}
        end
        it ':checkテンプレートを表示すること' do
          expect(response).to render_template :check
        end
        it 'フルハウスがインスタンス変数に代入されること' do
          expect(assigns(:answer)[:answer]).to eq 'フルハウス'
        end
      end
      context 'フラッシュ役がpostされた時' do
        before do
          post :check, params: {hands: 'S8 S7 S6 S5 S1'}
        end
        it ':checkテンプレートを表示すること' do
          expect(response).to render_template :check
        end
        it 'フラッシュがインスタンス変数に代入されること' do
          expect(assigns(:answer)[:answer]).to eq 'フラッシュ'
        end
      end
      context 'ストレート役がpostされた時' do
        before do
          post :check, params: {hands: 'D6 S5 D4 H3 C2'}
        end
        it ':checkテンプレートを表示すること' do
          expect(response).to render_template :check
        end
        it 'ストレートがインスタンス変数に代入されること' do
          expect(assigns(:answer)[:answer]).to eq 'ストレート'
        end
      end
      context '3カード役がpostされた時' do
        before do
          post :check, params: {hands: 'S12 C12 D12 S5 C3'}
        end
        it ':checkテンプレートを表示すること' do
          expect(response).to render_template :check
        end
        it '3カードがインスタンス変数に代入されること' do
          expect(assigns(:answer)[:answer]).to eq '3カード'
        end
      end
      context '2ペア役がpostされた時' do
        before do
          post :check, params: {hands: 'H13 D13 C2 D2 H11'}
        end
        it ':checkテンプレートを表示すること' do
          expect(response).to render_template :check
        end
        it '2ペアがインスタンス変数に代入されること' do
          expect(assigns(:answer)[:answer]).to eq '2ペア'
        end
      end
      context 'ワンペア役がpostされた時' do
        before do
          post :check, params: {hands: 'H13 D13 C2 D3 H1'}
        end
        it ':checkテンプレートを表示すること' do
          expect(response).to render_template :check
        end
        it 'ワンペアがインスタンス変数に代入されること' do
          expect(assigns(:answer)[:answer]).to eq 'ワンペア'
        end
      end
      context 'ハイカード役がpostされた時' do
        before do
          post :check, params: {hands: 'C13 D12 C11 H8 H10'}
        end
        it ':checkテンプレートを表示すること' do
          expect(response).to render_template :check
        end
        it 'ハイカードがインスタンス変数に代入されること' do
          expect(assigns(:answer)[:answer]).to eq 'ハイカード'
        end
      end
    end
  end
end