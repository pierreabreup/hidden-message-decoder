require 'date'

class DecodeRouteService
  def initialize(source)
    @source = source
  end

  def decode
    if source_name_as_klass
      return source_name_as_klass.new(source.name, DataFetch.get_by_url(source.url)).decode
    end

    []
  end


  private

  def source
    @source
  end

  def source_name_as_klass
    "RouteDecode::#{@source.name.singularize.classify}".constantize
  rescue NameError => e
    #send to graylog (Graylog must be enabled ) OR create a default decode class.
    nil
  end
end
