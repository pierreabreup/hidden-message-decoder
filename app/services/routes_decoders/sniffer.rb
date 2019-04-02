module RouteDecode
  class Sniffer
    include BaseDecode

    def decode
      node_times = remove_invalids_index(data[0])
      parcial_routes = remove_invalids_index(data[1])
      node_route_sequences = remove_invalids_index(data[2])

      route_ids_times = parcial_routes.inject({}) { |hsh, r| hsh.merge( r[0] => "#{r[1]}#{r[2]}" ) } # route_id => "#{time}#{time_zone}""
      node_time_ids_route_ids = node_route_sequences.inject({}) { |hsh, r| hsh.merge( r[1] => r[0] ) } #node_time_id => route_id

      node_times.map do |node_time|
        duration_in_milliseconds = node_time[3]
        node_time_id = node_time[0]

        route_id    = node_time_ids_route_ids[node_time_id]
        route_time_as_datetime = DateTime.parse(route_ids_times[route_id])

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


    private

    #use 1..-1 because the first row is the csv head
    def remove_invalids_index(ary)
      ary[1..-1]
    end
  end
end
