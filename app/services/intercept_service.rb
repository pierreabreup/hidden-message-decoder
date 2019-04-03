class InterceptService
  attr_reader :logs

  def parse_routes(sources)
    sources.each do |source|
      routes = DecodeRouteService.new(source).decode
      send_status = SendRoutesService.new(source.name, routes).send

      @logs ||= []
      @logs.concat(send_status)
    end
  end
end
