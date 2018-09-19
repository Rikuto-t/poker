module API
  class Root < Grape::API
    # http://localhost:3000/api/
    prefix 'api'
    format :json


    mount API::Ver1::Root
    # mount API::Ver2::Root



    # 不正なURLにアクセスした時の処理
    route :any, '*path' do
      error!({"error": [{"msg": "不正なURLです。"}]},404)
    end




  end
end



