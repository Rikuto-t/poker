module API
  module Ver1
    class Root < Grape::API
      # http://localhost:3000/api/v1/
      version 'v1'
      format :json

      mount API::Ver1::Cards
      # mount API::Ver1::Products


    end
  end
end