require 'net/http'
require 'uri'
require 'json'


class SendRoutesService
  def initialize(source_name, routes)
    @source_name = source_name
    @routes = routes
  end

  def send
    status = []
    routes.each do |route|
      uri = URI.parse(Settings.message.destination.url)

      header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme.eql?('https')

      request = Net::HTTP::Post.new(uri.path, header)
      request.body = route.merge(
        passphrase: Settings.message.passphrase,
        source: source_name,
        start_time: date_time_as_utc_string(route[:start_time]),
        end_time: date_time_as_utc_string(route[:end_time])
      ).to_json
      response = http.request(request)

      status << {
        status: response.code,
        message: response.message,
        route_sent: request.body
      }
    end

    status
  end

  private

  def routes
    @routes
  end

  def source_name
    @source_name
  end

  def date_time_as_utc_string(dt)
    dt.new_offset(0).to_s.sub('+00:00','')
  end

end
