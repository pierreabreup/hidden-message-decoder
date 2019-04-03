RSpec.describe 'SendRoutesService' do
  describe 'When there are routes' do
    context 'and send them' do
      it 'return status' do
        routes = [
          {:source=>"sniffers", :start_node=>"lambda", :start_time=>DateTime.parse('Tue, 31 Dec 2030 13:00:06 +0000'), :end_node=>"lambda", :end_time=>DateTime.parse('Tue, 31 Dec 2030 13:00:07 +0000')},
        ]

        expected = [{
          :status=>"201",
          :message=>"Created",
          :route_sent=>"{\"source\":\"sniffers\",\"start_node\":\"lambda\",\"start_time\":\"2030-12-31T13:00:06\",\"end_node\":\"lambda\",\"end_time\":\"2030-12-31T13:00:07\",\"passphrase\":\"Kans4s-i$-g01ng-by3-bye\"}"
        }]

        expect(SendRoutesService.new('sniffers', routes).send).to eq(expected)
      end

    end
  end

  describe "When there aren't routes" do
    context 'and send them' do
      it 'return nothing' do
        expect(SendRoutesService.new('sniffers', []).send).to be_empty
      end
    end
  end
end

