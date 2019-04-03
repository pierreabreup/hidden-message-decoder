RSpec.describe 'RouteDecode::Sentinel' do
  describe 'When there are data' do
    context 'and decode them' do

      it 'build nothing when node name is invalid' do
        data = [
          [
            ["route_id", "node", "index", "time"],
            ["1", "alpha", "0", "2030-12-31T22:00:01+09:00"],
            ["1", "zeta", "1", "2030-12-31T18:00:02+05:00"]
          ]
        ]

        expect(RouteDecode::Sentinel.new('sentinels', data).decode).to be_empty
      end


      it 'built new route data' do
        data = [
          [
            ["route_id", "node", "index", "time"],
            ["1", "alpha", "0", "2030-12-31T22:00:01+09:00"],
            ["1", "beta", "1", "2030-12-31T18:00:02+05:00"],
            ["1", "gamma", "2", "2030-12-31T16:00:03+03:00"],
            ["2", "delta", "0", "2030-12-31T22:00:02+09:00"],
            ["2", "beta", "1", "2030-12-31T18:00:03+05:00"],
            ["2", "gamma", "2", "2030-12-31T16:00:04+03:00"],
            ["3", "zeta", "0", "2030-12-31T22:00:02+09:00"]
          ]
        ]

        expected = [
          {:source=>"sentinels", :start_node=>"alpha", :start_time=>DateTime.parse('Tue, 31 Dec 2030 22:00:01 +0900'), :end_node=>"beta", :end_time=>DateTime.parse('Tue, 31 Dec 2030 18:00:02 +0500')},
          {:source=>"sentinels", :start_node=>"alpha", :start_time=>DateTime.parse('Tue, 31 Dec 2030 22:00:01 +0900'), :end_node=>"delta", :end_time=>DateTime.parse('Tue, 31 Dec 2030 22:00:02 +0900')},
          {:source=>"sentinels", :start_node=>"alpha", :start_time=>DateTime.parse('Tue, 31 Dec 2030 22:00:01 +0900'), :end_node=>"gamma", :end_time=>DateTime.parse('Tue, 31 Dec 2030 16:00:03 +0300')},
          {:source=>"sentinels", :start_node=>"alpha", :start_time=>DateTime.parse('Tue, 31 Dec 2030 22:00:01 +0900'), :end_node=>"beta", :end_time=>DateTime.parse('Tue, 31 Dec 2030 18:00:03 +0500')},
          {:source=>"sentinels", :start_node=>"alpha", :start_time=>DateTime.parse('Tue, 31 Dec 2030 22:00:01 +0900'), :end_node=>"gamma", :end_time=>DateTime.parse('Tue, 31 Dec 2030 16:00:04 +0300')},
          {:source=>"sentinels", :start_node=>"beta", :start_time=>DateTime.parse('Tue, 31 Dec 2030 18:00:02 +0500'), :end_node=>"delta", :end_time=>DateTime.parse('Tue, 31 Dec 2030 22:00:02 +0900')},
          {:source=>"sentinels", :start_node=>"beta", :start_time=>DateTime.parse('Tue, 31 Dec 2030 18:00:02 +0500'), :end_node=>"gamma", :end_time=>DateTime.parse('Tue, 31 Dec 2030 16:00:03 +0300')},
          {:source=>"sentinels", :start_node=>"beta", :start_time=>DateTime.parse('Tue, 31 Dec 2030 18:00:02 +0500'), :end_node=>"beta", :end_time=>DateTime.parse('Tue, 31 Dec 2030 18:00:03 +0500')},
          {:source=>"sentinels", :start_node=>"beta", :start_time=>DateTime.parse('Tue, 31 Dec 2030 18:00:02 +0500'), :end_node=>"gamma", :end_time=>DateTime.parse('Tue, 31 Dec 2030 16:00:04 +0300')},
          {:source=>"sentinels", :start_node=>"delta", :start_time=>DateTime.parse('Tue, 31 Dec 2030 22:00:02 +0900'), :end_node=>"gamma", :end_time=>DateTime.parse('Tue, 31 Dec 2030 16:00:03 +0300')},
          {:source=>"sentinels", :start_node=>"delta", :start_time=>DateTime.parse('Tue, 31 Dec 2030 22:00:02 +0900'), :end_node=>"beta", :end_time=>DateTime.parse('Tue, 31 Dec 2030 18:00:03 +0500')},
          {:source=>"sentinels", :start_node=>"delta", :start_time=>DateTime.parse('Tue, 31 Dec 2030 22:00:02 +0900'), :end_node=>"gamma", :end_time=>DateTime.parse('Tue, 31 Dec 2030 16:00:04 +0300')},
          {:source=>"sentinels", :start_node=>"gamma", :start_time=>DateTime.parse('Tue, 31 Dec 2030 16:00:03 +0300'), :end_node=>"beta", :end_time=>DateTime.parse('Tue, 31 Dec 2030 18:00:03 +0500')},
          {:source=>"sentinels", :start_node=>"gamma", :start_time=>DateTime.parse('Tue, 31 Dec 2030 16:00:03 +0300'), :end_node=>"gamma", :end_time=>DateTime.parse('Tue, 31 Dec 2030 16:00:04 +0300')},
          {:source=>"sentinels", :start_node=>"beta", :start_time=>DateTime.parse('Tue, 31 Dec 2030 18:00:03 +0500'), :end_node=>"gamma", :end_time=>DateTime.parse('Tue, 31 Dec 2030 16:00:04 +0300')}
        ]
        expect(RouteDecode::Sentinel.new('sentinels', data).decode).to eq(expected)
      end

    end
  end
end
