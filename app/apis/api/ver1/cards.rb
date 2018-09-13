module API
  module Ver1
    class Cards < Grape::API
      resource :cards do
        require 'json'

        # GET /api/v1/cards
        desc 'Return all cards.'
        # get do
        #   result = []
        #   cards = ["H1 H12 H10 H5 H3","H1 H12 H10 H5 H3"]
        #   cards.each do |card|
        #     hand = CardForm.new(card)
        #     result << hand.yaku
        #   end
        # end


        # GET /api/v1/cards/check
        desc 'Return a hands.'
        # params do
        #   requires :cards, type: Array, desc: '手札'
        # end
        post 'check' do
          result = []
          params[:cards].each do |card|
            hand = CardForm.new(card)
            result << hand.yaku
          end

          result
        end
      end
    end
  end
end