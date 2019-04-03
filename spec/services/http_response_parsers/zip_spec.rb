RSpec.describe 'HttpResponseParse::Zip' do
  describe 'When request a URI of single CSV zip', scope: :http_response do
    let!(:uri)  { URI.parse("http://challenge.distribusion.com/the_one/routes?passphrase=Kans4s-i%24-g01ng-by3-bye&source=sentinels") }
    let!(:body) { HttpResponseParse::Zip.new(uri).body }

    context 'and returns 200' do
      it { expect(body_is_array?(body)).to be(true) }

      it "csv content is read" do
        expected_data = [
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
        expect(body).to eq(expected_data)
      end
    end
  end

  describe 'When request a URI of multiple CSV zip', scope: :http_response do
    let!(:uri)  { URI.parse("http://challenge.distribusion.com/the_one/routes?passphrase=Kans4s-i%24-g01ng-by3-bye&source=sniffers") }
    let!(:body) { HttpResponseParse::Zip.new(uri).body }

    context 'and returns 200' do
      it { expect(body_is_array?(body)).to be(true) }

      it "csvs contents are read" do
        expected_data = [
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

        expect(body).to eq(expected_data)
      end
    end
  end

  describe 'When request a URI of multiple JSON zip', scope: :http_response do
    let!(:uri)  { URI.parse("http://challenge.distribusion.com/the_one/routes?passphrase=Kans4s-i%24-g01ng-by3-bye&source=loopholes") }
    let!(:body) { HttpResponseParse::Zip.new(uri).body }

    context 'and returns 200' do
      it { expect(body_is_array?(body)).to be(true) }

      it "json contents are read" do
        expected_data = [
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


        expect(body).to eq(expected_data)
      end
    end
  end


end

