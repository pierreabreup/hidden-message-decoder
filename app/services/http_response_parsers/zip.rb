require 'open-uri'
require 'zip'
require 'csv'

module HttpResponseParse
  class Zip
    def initialize(uri)
      @uri = uri
    end

    def body
      data = []

      ::Zip::File.open_buffer(uri.open) do |zip|
        zip.each do |entry|
          if entry.name.split('/').last.match(/\A[^\.].+\.csv\z/)
            begin
              data.concat(CSV.parse(entry.get_input_stream.read))
            rescue CSV::MalformedCSVError => e
              #maybe record this event on Graylog for further investigation
               count_columns = []
               rows = entry
                .get_input_stream
                .read
                .split(/\n/)[1..-1]
                .map do |line|
                  columns = line.split(',').map {|column| column.strip.gsub(/\A"|"$/,'') }
                  count_columns << columns.size

                  columns
                end
              if count_columns.uniq.size == 1 #total of CSV row columns must be the same
                data.concat(rows)
              end
            rescue Exception => e
              puts 'Are you kidding me ?'
              #send this event to Sentry (Yes, Sentry must be configured before)
            end
          end
        end
      end

      data
    end

    private

    def uri
      @uri
    end
  end
end
