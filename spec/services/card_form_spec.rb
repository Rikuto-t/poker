require 'rails_helper'

describe CardForm do
  context '期待する引数が与えられた時' do
    it 'ストレートフラッシュと判定すること' do
      @hand = CardForm.new("C7 C6 C5 C4 C3")
      expect(@hand.yaku[:answer]).to eq "ストレートフラッシュ"
    end
    it '4カード役と判定すること' do
      @hand = CardForm.new("D6 H6 S6 C6 S13")
      expect(@hand.yaku[:answer]).to eq "4カード"
    end
    it 'フルハウス役と判定すること' do
      @hand = CardForm.new("H9 C9 S9 H1 C1")
      expect(@hand.yaku[:answer]).to eq "フルハウス"
    end
    it 'フラッシュ役と判定すること' do
      @hand = CardForm.new("S8 S7 S6 S5 S1")
      expect(@hand.yaku[:answer]).to eq "フラッシュ"
    end
    it 'ストレート役と判定すること' do
      @hand = CardForm.new("D6 S5 D4 H3 C2")
      expect(@hand.yaku[:answer]).to eq "ストレート"
    end
    it '3カード役と判定すること' do
      @hand = CardForm.new("S12 C12 D12 S5 C3")
      expect(@hand.yaku[:answer]).to eq "3カード"
    end
    it '2ペア役と判定すること' do
      @hand = CardForm.new("H13 D13 C2 D2 H11")
      expect(@hand.yaku[:answer]).to eq "2ペア"
    end
    it 'ワンペア役と判定すること' do
      @hand = CardForm.new("H13 D13 C2 D3 H1")
      expect(@hand.yaku[:answer]).to eq "ワンペア"
    end
    it 'ハイカード役と判定すること' do
      @hand = CardForm.new("C13 D12 C11 H8 H10")
      expect(@hand.yaku[:answer]).to eq "ハイカード"
    end
  end
  context '期待しない値が引数が与えられた時' do
    context '空白が与えられた時' do
      it '期待されるエラーメッサージが返されること' do
        @hand = CardForm.new("")
        expect(@hand.get_error_msg[0]).to eq "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11)"
      end
    end
    context '重複する値が与えられたとき' do
      it '期待されるエラーメッサージが返されること' do
        @hand = CardForm.new("S8 S7 S6 S5 S5")
        expect(@hand.get_error_msg[0]).to eq "同じカードが入力されています"
      end
    end
    context '正しく5枚分の値が与えられなかった時' do
      it '期待されるエラーメッサージが返されること' do
        @hand = CardForm.new("")
        expect(@hand.get_error_msg[0]).to eq "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11)"
      end
    end
  end
end

