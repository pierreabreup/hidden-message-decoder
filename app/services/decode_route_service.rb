require 'date'

class DecodeRouteService
  def initialize(source_name)
    @source_name = source_name
  end

  def decode
    source_url = Settings.message.sources[source_name].url

    if source_name_as_klass
      return source_name_as_klass.new(source_name, DataFetch.get_by_url(source_url)).decode
    end

    []
  end


  private

  def source_name
    @source_name
  end

  def source_name_as_klass
    "RouteDecode::#{@source_name.to_s.singularize.classify}".constantize
  rescue NameError => e
    #send to graylog (Graylog must be enabled ) OR create a default decode class.
    nil
  end
end
