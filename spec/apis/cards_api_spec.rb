require 'rails_helper'

include API

describe 'api', :type => :request do

  context '期待される値がpostされた時' do
    it 'リクエストは201 OKとなること' do
      post '/api/v1/cards/check', params: {cards: ['H1 H13 H12 H11 H10']}
      expect(response.status).to eq 201
    end
    context '期待される値が1組postされた時' do
      it 'ストレートフラッシュと判定すること' do
        post '/api/v1/cards/check', params: {cards: ['H1 H13 H12 H11 H10']}
        expect(JSON.parse(response.body, {symbolize_names: true})).to eq ({'results': [{'hand': 'H1 H13 H12 H11 H10', 'answer': 'ストレートフラッシュ', 'best': true}]})
      end
      it '4カードと判定すること' do
        post '/api/v1/cards/check', params: {cards: ['D6 H6 S6 C6 S13']}
        expect(JSON.parse(response.body, {symbolize_names: true})).to eq ({'results': [{'hand': 'D6 H6 S6 C6 S13', 'answer': '4カード', 'best': true}]})
      end
      it 'フルハウスと判定すること' do
        post '/api/v1/cards/check', params: {cards: ['H9 C9 S9 H1 C1']}
        expect(JSON.parse(response.body, {symbolize_names: true})).to eq ({'results': [{'hand': 'H9 C9 S9 H1 C1', 'answer': 'フルハウス', 'best': true}]})
      end
      it 'フラッシュと判定すること' do
        post '/api/v1/cards/check', params: {cards: ['S8 S7 S6 S5 S1']}
        expect(JSON.parse(response.body, {symbolize_names: true})).to eq ({'results': [{'hand': 'S8 S7 S6 S5 S1', 'answer': 'フラッシュ', 'best': true}]})
      end
      it 'ストレートと判定すること' do
        post '/api/v1/cards/check', params: {cards: ['D6 S5 D4 H3 C2']}
        expect(JSON.parse(response.body, {symbolize_names: true})).to eq ({'results': [{'hand': 'D6 S5 D4 H3 C2', 'answer': 'ストレート', 'best': true}]})
      end
      it '3カードと判定すること' do
        post '/api/v1/cards/check', params: {cards: ['S12 C12 D12 S5 C3']}
        expect(JSON.parse(response.body, {symbolize_names: true})).to eq ({'results': [{'hand': 'S12 C12 D12 S5 C3', 'answer': '3カード', 'best': true}]})
      end
      it '2ペアと判定すること' do
        post '/api/v1/cards/check', params: {cards: ['H13 D13 C2 D2 H11']}
        expect(JSON.parse(response.body, {symbolize_names: true})).to eq ({'results': [{'hand': 'H13 D13 C2 D2 H11', 'answer': '2ペア', 'best': true}]})
      end
      it 'ワンペアと判定すること' do
        post '/api/v1/cards/check', params: {cards: ['H13 D13 C2 D3 H1']}
        expect(JSON.parse(response.body, {symbolize_names: true})).to eq ({'results': [{'hand': 'H13 D13 C2 D3 H1', 'answer': 'ワンペア', 'best': true}]})
      end
      it 'ハイカードと判定すること' do
        post '/api/v1/cards/check', params: {cards: ['C13 D12 C11 H8 H10']}
        expect(JSON.parse(response.body, {symbolize_names: true})).to eq ({'results': [{'hand': 'C13 D12 C11 H8 H10', 'answer': 'ハイカード', 'best': true}]})
      end
    end
    context '期待される値が複数組postされた時' do
      it '正しい値を返すとこと' do
        post '/api/v1/cards/check', params: {cards: ['H1 H13 H12 H11 H10', 'H9 C9 S9 H2 C2', 'C13 D12 C11 H8 H2']}
        expect(JSON.parse(response.body, {symbolize_names: true})).to eq ({'results': [{'hand': 'H1 H13 H12 H11 H10', 'answer': 'ストレートフラッシュ', 'best': true}, {'hand': 'H9 C9 S9 H2 C2', 'answer': 'フルハウス', 'best': false}, {'hand': 'C13 D12 C11 H8 H2', 'answer': 'ハイカード', 'best': false}]})
      end
    end
  end

  context '期待されない値がpostされた時' do
    context '期待されない値が1組postされた時' do
      it '正しいエラーメッセージを返すこと' do
        post '/api/v1/cards/check', params: {cards: ['H9 C9 S9 H1 H1']}
        expect(JSON.parse(response.body, {symbolize_names: true})).to eq ({'errors': [{'hand': 'H9 C9 S9 H1 H1', 'msg': '同じカードが入力されています'}]})
      end
      it '正しいエラーメッセージを返すこと' do
        post '/api/v1/cards/check', params: {cards: ['']}
        expect(JSON.parse(response.body, {symbolize_names: true})).to eq ({'errors': [{'hand': '', 'msg': '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11)'}]})
      end
      it '正しいエラーメッセージを返すこと' do
        post '/api/v1/cards/check', params: {cards: ['C13 D12 C11 H8 H']}
        expect(JSON.parse(response.body, {symbolize_names: true})).to eq ({'errors': [{'hand': 'C13 D12 C11 H8 H', 'msg': '5番目のカード文字が不正です (H)'}]})
      end
      it '正しいエラーメッセージを返すこと' do
        post '/api/v1/cards/check', params: {cards: ['C13 D12 C11 Hd8 Hfdas']}
        expect(JSON.parse(response.body, {symbolize_names: true})).to eq ({'errors': [{'hand': 'C13 D12 C11 Hd8 Hfdas', 'msg': '4番目のカード文字が不正です (Hd8)'}, {'hand': 'C13 D12 C11 Hd8 Hfdas', 'msg': '5番目のカード文字が不正です (Hfdas)'}]})
      end
    end
    context '期待されない値が複数組postされた時' do
      it '正しいエラーメッセージを返すこと' do
        post '/api/v1/cards/check', params: {cards: ['H9 C9 S9 H1 H1', 'C13 D12 C11 H8']}
        expect(JSON.parse(response.body, {symbolize_names: true})).to eq ({'errors': [{'hand': 'H9 C9 S9 H1 H1', 'msg': '同じカードが入力されています'}, {'hand': 'C13 D12 C11 H8', 'msg': '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11)'}]})
      end
    end
  end

  context '期待される値と期待されない値が共にpostされた時' do
    it '正しい役判定結果とエラーメッセージを共に返すこと' do
      post '/api/v1/cards/check', params: {cards: ['H1 H13 H12 H11 H10', 'H9 C9 S9 H2 C2', 'C13 D12 C11 H8 H8']}
      expect(JSON.parse(response.body, {symbolize_names: true})).to eq ({'results': [{'hand': 'H1 H13 H12 H11 H10', 'answer': 'ストレートフラッシュ', 'best': true}, {'hand': 'H9 C9 S9 H2 C2', 'answer': 'フルハウス', 'best': false}], 'errors': [{'hand': 'C13 D12 C11 H8 H8', 'msg': '同じカードが入力されています'}]})
    end
  end

  context '不正なアクセスの時' do
    context 'getでアクセスした時' do
      before do
        get '/api/v1/cards/check'
      end
      it 'リクエストは404エラーとなること' do
        expect(response.status).to eq 404
      end
      it '正しいエラーメッセージを返すこと' do
        expect(JSON.parse(response.body, {symbolize_names: true})).to eq ({'error': [{'msg': '不正なURLです。'}]})
      end
    end
    context '不正なURLでアクセスした時' do
      before do
        post '/api/v1/'
      end
      it 'リクエストは404エラーとなること' do
        expect(response.status).to eq 404
      end
      it '正しいエラーメッセージを返すこと' do
        expect(JSON.parse(response.body, {symbolize_names: true})).to eq ({'error': [{'msg': '不正なURLです。'}]})
      end
    end
  end
end
