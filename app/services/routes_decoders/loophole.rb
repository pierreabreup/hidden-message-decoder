module RouteDecode
  class Loophole
    include BaseDecode

    def decode
      node_pairs = data[0]['node_pairs'].inject({}) { |hsh, np| hsh.merge( np['id'] => np ) }
      parcial_routes = data[1]['routes']


      parcial_routes.map do |parcial_route|
        node_pair_id = parcial_route['node_pair_id']
        if node_pair = node_pairs[node_pair_id]
          build_new_route_data(
            {
              node_name: node_pair['start_node'],
              time: DateTime.parse(parcial_route['start_time'])
            },
            {
              node_name: node_pair['end_node'],
              time: DateTime.parse(parcial_route['end_time'])
            }
          )
        end
      end.compact

    end
  end
end
