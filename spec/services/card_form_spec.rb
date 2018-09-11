require 'rails_helper'

describe CardForm do
  context '期待する引数が与えられた時' do
    it 'ストレートフラッシュと判定すること' do
      @hand = CardForm.new("C7 C6 C5 C4 C3")
      expect(@hand.yaku[0][:answer]).to eq "ストレートフラッシュ"
    end
    it '4カード役と判定すること' do
      @hand = CardForm.new("D6 H6 S6 C6 S13")
      expect(@hand.yaku[0][:answer]).to eq "4カード"
    end
    it 'フルハウス役と判定すること' do
      @hand = CardForm.new("H9 C9 S9 H1 C1")
      expect(@hand.yaku[0][:answer]).to eq "フルハウス"
    end
    it 'フラッシュ役と判定すること' do
      @hand = CardForm.new("S8 S7 S6 S5 S1")
      expect(@hand.yaku[0][:answer]).to eq "フラッシュ"
    end
    it 'ストレート役と判定すること' do
      @hand = CardForm.new("D6 S5 D4 H3 C2")
      expect(@hand.yaku[0][:answer]).to eq "ストレート"
    end
    it '3カード役と判定すること' do
      @hand = CardForm.new("S12 C12 D12 S5 C3")
      expect(@hand.yaku[0][:answer]).to eq "3カード"
    end
    it '2ペア役と判定すること' do
      @hand = CardForm.new("H13 D13 C2 D2 H11")
      expect(@hand.yaku[0][:answer]).to eq "2ペア"
    end
    it 'ワンペア役と判定すること' do
      @hand = CardForm.new("H13 D13 C2 D3 H1")
      expect(@hand.yaku[0][:answer]).to eq "ワンペア"
    end
    it 'ハイカード役と判定すること' do
      @hand = CardForm.new("C13 D12 C11 H8 H10")
      expect(@hand.yaku[0][:answer]).to eq "ハイカード"
    end
  end
  context '期待しない値が引数が与えられた時' do
    context '空白が与えられた時' do
      it '期待されるエラーメッサージが返されること' do
        @hand = CardForm.new("")
        expect(@hand.myvalid[0]).to eq "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11)"
      end
    end
    context '重複するカードがpostされたとき' do
      it '期待されるエラーメッサージが返されること' do
        @hand = CardForm.new("")
        expect(@hand.myvalid[0]).to eq "重複するカードがpostされたとき"
      end
    end
    context 'カードが正しく5枚入力されていない時' do
      it '期待されるエラーメッサージが返されること' do
        @hand = CardForm.new("")
        expect(@hand.myvalid[0]).to eq "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11)"
      end
    end
  end
end


#
# describe Hand, type: :model do
#   context '期待される値が入力された時' do
#     it 'バリデーションをパスすること' do
#       @hand = Hand.new(content: "S1 H3 D9 C13 S11")
#       expect(@hand).to be_valid
#     end
#   end
#   context '不正な値が入力された時' do
#     context '空白が入力された時' do
#       it 'バリデーションをパスしないこと' do
#         @hand = Hand.new(content: "")
#         expect(@hand).not_to be_valid
#       end
#     end
#     context '重複するカードがpostされたとき' do
#       it 'バリデーションをパスしないこと' do
#         @hand = Hand.new(content: "S8 S7 S6 S5 S5")
#         expect(@hand).not_to be_valid
#       end
#     end
#     context '重複するカードがpostされたとき' do
#       it 'バリデーションをパスしないこと' do
#         @hand = Hand.new(content: "S8 S7 S6 S5 S5")
#         expect(@hand).not_to be_valid
#       end
#     end
#   end
# end