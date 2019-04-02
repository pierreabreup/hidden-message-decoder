module HttpResponseParse
  class Json
    include BaseParse

    def body
      ActiveSupport::JSON.decode(Net::HTTP.get(uri))
    end
  end
end
