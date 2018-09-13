module API
  module Ver1
    class Cards < Grape::API
      resource :cards do
        require 'json'


        post 'check' do
          results = {result: []} #結果が入る箱


          params[:cards].each do |card|

            hand = CardForm.new(card)

            if hand.myvalid == []
              results[:result] << hand.yaku
            else
              results[:error] = [{hand: card, msg: hand.myvalid[0]}]
            end
          end

          score_array = []
          i = 0
          while i < results.length
            score_array << results[:result][i][:score]
            i += 1
          end

          x = 0
          while x < results[:result].length
            if score_array[x] == score_array.max
              results[:result][x][:best] = true
            else
              results[:result][x][:best] = false
            end
            x += 1
          end

          y = 0
          while y < results[:result].length
            results[:result][y].delete(:score)
            y += 1
          end


          return results

        end
      end
    end
  end
end