module RouteDecode
  class Loophole
    include BaseDecode

    def safe_decode
      parcial_routes = data[1]['routes']
      node_pairs     = data[0]['node_pairs']
      .select { |np| node_pair_valid?(np) }
      .inject({}) { |hsh, np| hsh.merge( np['id'] => np ) }

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

    private

    def invalid_data?
      data[0].nil? ||
      data[1].nil? ||
      !data[0].respond_to?('rehash') ||
      !data[1].respond_to?('rehash')
    end

    def node_pair_valid?(node_pair)
      node_name_valid?(node_pair['start_node']) && node_name_valid?(node_pair['start_node'])
    end
  end
end
