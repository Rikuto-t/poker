module API
  module Ver1
    class Cards < Grape::API

      resource :cards do
        require 'json'

        # 不正なリクエスト時の処理
        rescue_from :all do |e|
          error!({ error: [{"msg": "不正なリクエストです。"}]},400)
        end


        #メイン処理
        post 'check' do

          results = {hand_result: [], errors: []} #結果が入る箱

          params[:cards].each do |card|

            hand = CardForm.new(card)

            if hand.myvalid == [] #バリデーションが通った時
              results[:hand_result] << hand.yaku
            else #バリデーションを通らなかった時
              results[:errors] << {hand: card, msg: hand.myvalid[0]}
            end
          end

          # 役のscoreをresultsに追加する処理
          if results[:hand_result] != []
            score_array = [] #役のscoreを入れる箱
            i = 0
            while i < results[:hand_result].length
              score_array << results[:hand_result][i][:score] #役のスコアを配列に入れる
              i += 1
            end

            #上記の処理で追加したscoreを利用し、強さを判定する処理
            x = 0
            while x < results[:hand_result].length
              if score_array[x] == score_array.max #スコアが入った配列中での最大値と等しい時
                results[:hand_result][x][:best] = true #ハッシュに best: true　を入れる
              else
                results[:hand_result][x][:best] = false #ハッシュに best: false を入れる
              end
              x += 1
            end

            # results[:hand_result]のscore要素を削除する処理
            y = 0
            while y < results[:hand_result].length
              results[:hand_result][y].delete(:score)
              y += 1
            end
          else
            results.delete(:hand_result) # resultsの中身がエラーのみの時はresultsからhand_result要素を削除する
          end

          # エラーが出なかった時はresultsからerror要素を削除する
          if results[:errors] == []
            results.delete(:errors)
          end

          return results #戻り値

        end
      end
    end
  end
end