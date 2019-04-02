module RouteDecode
  module BaseDecode
    def initialize(source_name, data)
      @data = data
      @source_name = source_name
    end

    private

    def data
      @data
    end

    def source_name
      @source_name
    end

    def node_name_valid?(node_name)
      Settings.message.valid_node_names.include?(node_name)
    end

    def build_new_route_data(start_route, end_route)
      {
        source: source_name,
        start_node: start_route[:node_name],
        start_time: start_route[:time],
        end_node: end_route[:node_name],
        end_time: end_route[:time]
      }
    end
  end
end
