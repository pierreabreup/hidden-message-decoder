RSpec.describe 'HttpResponseParse::Json' do
  describe 'When request a URI', scope: :http_response do
    let!(:uri)  { URI.parse("https://jsonplaceholder.typicode.com/todos/1") }
    let!(:response) { HttpResponseParse::Json.new(uri) }

    context 'and returns 200' do
      it 'not raise JSON::ParserError exception' do
        expect { response.raw_body }.not_to raise_error(JSON::ParserError)
      end

      it 'not raise any exception' do
        expect { response.raw_body }.not_to raise_error(Exception)
      end

      it { expect(body_is_array?(response.body)).to be(true) }
    end
  end
end

