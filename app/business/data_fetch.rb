class DataFetch
  class << self
    def get_by_url(url)
      uri = URI.parse(url)
      query_string = URI.decode_www_form(uri.query || '') << ['passphrase', Settings.message.passphrase]
      uri.query = URI.encode_www_form(query_string)

      HttpResponseService.new(uri).body
    end
  end
end
