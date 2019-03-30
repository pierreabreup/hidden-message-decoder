require 'net/http'

class HttpResponseService
  def initialize(uri)
    @uri = uri
  end

  def body
    case response_content_type(uri)
    when 'application/zip'
      HttpResponseParse::Zip.new(uri).body
    when 'application/json'
      HttpResponseParse::Json.new(uri).body
    else
      Net::HTTP.get(uri)
    end
  end

  private

  def uri
    @uri
  end

  def response_content_type(req_uri, limit = 10)
    raise ArgumentError, 'HTTP redirect too deep' if limit == 0

    Net::HTTP.start(req_uri.host, req_uri.port, use_ssl: req_uri.scheme.eql?('https') ) do |http|
      request = Net::HTTP::Get.new(req_uri)
      http.request(request) do |response|

        case response
          when Net::HTTPSuccess
            return response['Content-type']
          when Net::HTTPRedirection
            return response_content_type(URI.parse(response['location']), limit - 1)
          else
            response.error!
        end
      end
    end


  end
end
