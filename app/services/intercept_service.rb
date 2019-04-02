class InterceptService
  attr_reader :logs

  def parse_routes
    Settings.message.sources.keys.each do |source_name|
      routes = DecodeRouteService.new(source_name).decode
      send_status = SendRoutesService.new(source_name, routes).send

      @logs ||= []
      @logs.concat(send_status)
    end
  end
end
