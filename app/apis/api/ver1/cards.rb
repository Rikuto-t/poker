require 'json'
module API
  module Ver1
    class Cards < Grape::API

      SYM_CARDS = :cards

      resource :cards do
        # 不正なリクエスト時の処理
        rescue_from :all do |e|
          error!({error: [{"msg": "不正なリクエストです。"}]}, 400)
        end

        #メイン処理
        post 'check' do
          
          results = []
          errors = []
          
          params[SYM_CARDS].each do |card|

            hand = CardForm.new(card)

            if hand.get_error_msg.empty? #バリデーションが通った時
              results << hand.yaku
            else #バリデーションが通らなかった時
              hand.get_error_msg.each do |error|
                errors << {hand: card, msg: error}
              end
            end
          end

          # 役のscoreをresponseに追加する処理
          if results.present?

            score = [] #役のscoreを入れる箱

            results.each do |result|
              score << result[:score]
            end

            results.each_with_index do |result, index|
              if score[index] == score.max #スコアが入った配列中での最大値と等しい時
                result[:best] = true #ハッシュに best: true　を入れる
              else #等しくない時
                result[:best] = false #ハッシュに best: false を入れる
              end
            end

            # resultsからscore要素を削除する
            results.each do |result|
              result.delete(:score)
            end

          end
          
          response = {}
          response[:results] = results if results.present?
          response[:errors] = errors if errors.present?

          return response #戻り値
          
        end
      end
    end
  end
end