module HttpResponseParse
  class Json
    include BaseParse

    def raw_body
      ::ActiveSupport::JSON.decode(Net::HTTP.get(uri))
    end
  end
end
