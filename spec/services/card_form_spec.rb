require 'rails_helper'



describe CardForm do
  before do
    @hand = CardForm.new("S8 S7 S6 S3 H15")
  end
  it 'インスタンス変数に値が入ること' do
    expect(@hand.hands).to eq "S8 S7 S6 S3 H15"
  end
  it '役判定メソッドが正しく動くこと' do
    expect(@hand.yaku[0][:answer]).to eq "ハイカード"
  end
end


describe Hand, type: :model do
  context '期待される値が入力された時' do
    it 'バリデーションをパスすること' do
      @hand = Hand.new(content: "S1 H3 D9 C13 S11")
      expect(@hand).to be_valid
    end
  end
  context '不正な値が入力された時' do
    context '空白が入力された時' do
      it 'バリデーションをパスしないこと' do
        @hand = Hand.new(content: "")
        expect(@hand).not_to be_valid
      end
    end
    context '重複するカードがpostされたとき' do
      it 'バリデーションをパスしないこと' do
        @hand = Hand.new(content: "S8 S7 S6 S5 S5")
        expect(@hand).not_to be_valid
      end
    end
    context '重複するカードがpostされたとき' do
      it 'バリデーションをパスしないこと' do
        @hand = Hand.new(content: "S8 S7 S6 S5 S5")
        expect(@hand).not_to be_valid
      end
    end
  end
end