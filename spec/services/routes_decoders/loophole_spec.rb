RSpec.describe 'RouteDecode::Loophole' do
  describe 'When there are data' do
    context 'and decode them' do

      it 'build nothing when node name is invalid' do
        data = [
          {"node_pairs"=>
            [
              {"id"=>"1", "start_node"=>"zeta", "end_node"=>"theta"}
            ]
          },
          {"routes"=>
            [
              {"route_id"=>"1", "node_pair_id"=>"1", "start_time"=>"2030-12-31T13:00:04Z", "end_time"=>"2030-12-31T13:00:05Z"}
            ]
          }
        ]

        expect(RouteDecode::Loophole.new('loopholes', data).decode).to be_empty
      end

      it 'built new route data' do
        data = [
          {"node_pairs"=>
            [
              {"id"=>"1", "start_node"=>"gamma", "end_node"=>"theta"},
              {"id"=>"2", "start_node"=>"beta", "end_node"=>"theta"},
              {"id"=>"3", "start_node"=>"theta", "end_node"=>"lambda"}
            ]
          },
          {"routes"=>
            [
              {"route_id"=>"1", "node_pair_id"=>"1", "start_time"=>"2030-12-31T13:00:04Z", "end_time"=>"2030-12-31T13:00:05Z"},
              {"route_id"=>"1", "node_pair_id"=>"3", "start_time"=>"2030-12-31T13:00:05Z", "end_time"=>"2030-12-31T13:00:06Z"},
              {"route_id"=>"2", "node_pair_id"=>"2", "start_time"=>"2030-12-31T13:00:05Z", "end_time"=>"2030-12-31T13:00:06Z"},
              {"route_id"=>"2", "node_pair_id"=>"3", "start_time"=>"2030-12-31T13:00:06Z", "end_time"=>"2030-12-31T13:00:07Z"},
              {"route_id"=>"3", "node_pair_id"=>"9", "start_time"=>"2030-12-31T13:00:00Z", "end_time"=>"2030-12-31T13:00:00Z"}
            ]
          }
        ]
        expected = [
          {:source=>"loopholes", :start_node=>"gamma", :start_time=>DateTime.parse('Tue, 31 Dec 2030 13:00:04 +0000'), :end_node=>"theta", :end_time=>DateTime.parse('Tue, 31 Dec 2030 13:00:05 +0000')},
          {:source=>"loopholes", :start_node=>"theta", :start_time=>DateTime.parse('Tue, 31 Dec 2030 13:00:05 +0000'), :end_node=>"lambda", :end_time=>DateTime.parse('Tue, 31 Dec 2030 13:00:06 +0000')},
          {:source=>"loopholes", :start_node=>"beta", :start_time=>DateTime.parse('Tue, 31 Dec 2030 13:00:05 +0000'), :end_node=>"theta", :end_time=>DateTime.parse('Tue, 31 Dec 2030 13:00:06 +0000')},
          {:source=>"loopholes", :start_node=>"theta", :start_time=>DateTime.parse('Tue, 31 Dec 2030 13:00:06 +0000'), :end_node=>"lambda", :end_time=>DateTime.parse('Tue, 31 Dec 2030 13:00:07 +0000')}
        ]
        expect(RouteDecode::Loophole.new('loopholes', data).decode).to eq(expected)
      end

    end
  end
end
