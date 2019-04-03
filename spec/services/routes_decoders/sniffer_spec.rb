RSpec.describe 'RouteDecode::Sniffer' do
  describe 'When there are data' do
    context 'and decode them' do

      it 'build nothing when node name is invalid' do
        data = [
          [
            ["node_time_id", "start_node", "end_node", "duration_in_milliseconds"],
            ["1", "zeta", "tau", "1000"]
          ],
          [
            ["route_id", "time", "time_zone"],
            ["1", "2030-12-31T13:00:06", "UTC±00:00"],
          ],
          [
            ["route_id", "node_time_id"],
            ["1", "1"]
          ]
        ]

        expect(RouteDecode::Sniffer.new('sniffers', data).decode).to be_empty
      end

      it 'new route data is built' do
        data = [
          [
            ["node_time_id", "start_node", "end_node", "duration_in_milliseconds"],
            ["1", "lambda", "tau", "1000"],
            ["2", "tau", "psi", "1000"],
            ["3", "psi", "omega", "1000"],
            ["4", "lambda", "psi", "1000"]
          ],
          [
            ["route_id", "time", "time_zone"],
            ["1", "2030-12-31T13:00:06", "UTC±00:00"],
            ["2", "2030-12-31T13:00:07", "UTC±00:00"],
            ["3", "2030-12-31T13:00:00", "UTC±00:00"]
          ],
          [
            ["route_id", "node_time_id"],
            ["1", "1"],
            ["1", "2"],
            ["1", "3"],
            ["2", "4"],
            ["2", "3"],
            ["3", "9"]
          ]
        ]
        expected = [
          {:source=>"sniffers", :start_node=>"lambda", :start_time=>DateTime.parse('Tue, 31 Dec 2030 13:00:06 +0000'), :end_node=>"lambda", :end_time=>DateTime.parse('Tue, 31 Dec 2030 13:00:07 +0000')},
          {:source=>"sniffers", :start_node=>"tau", :start_time=>DateTime.parse('Tue, 31 Dec 2030 13:00:06 +0000'), :end_node=>"tau", :end_time=>DateTime.parse('Tue, 31 Dec 2030 13:00:07 +0000')},
          {:source=>"sniffers", :start_node=>"psi", :start_time=>DateTime.parse('Tue, 31 Dec 2030 13:00:07 +0000'), :end_node=>"psi", :end_time=>DateTime.parse('Tue, 31 Dec 2030 13:00:08 +0000')},
          {:source=>"sniffers", :start_node=>"lambda", :start_time=>DateTime.parse('Tue, 31 Dec 2030 13:00:07 +0000'), :end_node=>"lambda", :end_time=>DateTime.parse('Tue, 31 Dec 2030 13:00:08 +0000')}
        ]
        expect(RouteDecode::Sniffer.new('sniffers', data).decode).to eq(expected)
      end

    end
  end
end
