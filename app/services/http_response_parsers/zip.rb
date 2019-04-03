require 'open-uri'
require 'zip'
require 'csv'

module HttpResponseParse
  class Zip
    include BaseParse

    def raw_body
      data = []

      ::Zip::File.open_buffer(uri.open) do |zip|
        zip.each do |entry|
          if csv_file_name?(entry.name)
            data << parse_csv_data(entry.get_input_stream.read)
          elsif json_file_name?(entry.name)
            data << parse_json_data(entry.get_input_stream.read)
          end
        end
      end

      data
    end

    private

    def csv_file_name?(name)
      name.split('/').last.match(/\A[^\.].+\.csv\z/)
    end

    def json_file_name?(name)
      name.split('/').last.match(/\A[^\.].+\.json\z/)
    end

    def parse_csv_data(csv_data)
      begin
        CSV.parse(csv_data)
      rescue CSV::MalformedCSVError => e
        #maybe record this event on Graylog for further investigation
         parse_malformed_csv(csv_data)
      rescue Exception => e
        #send this event to Sentry (Yes, Sentry must be configured before)
      end
    end

    def parse_malformed_csv(csv_data)
      rows_list = []
      count_columns = []


      rows = csv_data.split(/\n/).map do |line|
        columns = line.force_encoding("utf-8").split(',').map {|column| column.strip.gsub(/\A"|"$/,'') }
        count_columns << columns.size

        columns
      end
      if count_columns.uniq.size == 1 #total of CSV row columns must be the same
        rows_list.concat(rows)
      end

      rows_list
    end

    def parse_json_data(json_data)
      ActiveSupport::JSON.decode(json_data)
    end

  end
end
