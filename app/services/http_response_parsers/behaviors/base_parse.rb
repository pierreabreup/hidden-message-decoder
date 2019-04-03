module HttpResponseParse
  module BaseParse
    def initialize(uri)
      @uri = uri
    end

    def body #make sure the body method always returns an array
      raw_body.respond_to?('bsearch') ? raw_body : [raw_body]
    end

    private

    def uri
      @uri
    end
  end
end
