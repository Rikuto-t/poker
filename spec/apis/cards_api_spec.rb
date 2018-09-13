require 'rails_helper'

include API

describe "api", :type => :request do
  context '期待される値がpostされた時' do
    it 'リクエストは201 OKとなること' do
      post '/api/v1/cards/check', params: {cards: ["H1 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H2"]}
      expect(response.status).to eq 201
    end
    context '期待される値が1組postされた時' do
      context 'ストレートフラッシュ役がpostされた時' do
        it  '期待される値を返すこと' do
          post '/api/v1/cards/check', params: {cards: ["C7 C6 C5 C4 C3"]}
          expect
        end
      end
    end
  end
end