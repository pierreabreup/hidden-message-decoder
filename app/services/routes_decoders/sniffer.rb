module RouteDecode
  class Sniffer
    include BaseDecode

    def safe_decode
      node_times = remove_invalid_indexes(data[0]).select {|nt| node_time_valid?(nt) }
      parcial_routes = remove_invalid_indexes(data[1])
      node_route_sequences = remove_invalid_indexes(data[2])

      route_ids_times = parcial_routes.inject({}) { |hsh, r| hsh.merge( r[0] => "#{r[1]}#{r[2]}" ) } # route_id => "#{time}#{time_zone}""
      node_time_ids_route_ids = node_route_sequences.inject({}) { |hsh, r| hsh.merge( r[1] => r[0] ) } #node_time_id => route_id

      node_times.map do |node_time|
        duration_in_milliseconds = node_time[3]
        node_time_id = node_time[0]

        if route_id = node_time_ids_route_ids[node_time_id]
          if route_time = route_ids_times[route_id]
            route_time_as_datetime = DateTime.parse(route_time)

            build_new_route_data(
              {
                node_name: node_time[1],
                time: route_time_as_datetime,
              },
              {
                node_name: node_time[1],
                time: route_time_as_datetime + (duration_in_milliseconds.to_i / 1000).second
              }
            )
          end
        end
      end.compact
    end


    private

    def invalid_data?
      data[0].nil? ||
      data[1].nil? ||
      data[2].nil? ||
      !array?(data[0]) ||
      !array?(data[1]) ||
      !array?(data[2])
    end


    #use 1..-1 because the first row is the csv head
    def remove_invalid_indexes(ary)
      ary[1..-1]
    end

    def node_time_valid?(node_time)
      node_name_valid?(node_time[1]) && node_name_valid?(node_time[2])
    end
  end
end
