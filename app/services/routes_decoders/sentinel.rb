module RouteDecode
  class Sentinel
    include BaseDecode

    def decode
      routes = []

      #use 1..-1 because the first row is the csv head
      data.first[1..-1].map { |d|  d[3] = DateTime.parse(d[3]); d }
      .select { |d| node_name_valid?(d[1]) }
      .sort { |d1, d2| d1[3] <=> d2[3] }
      .combination(2) do |combination| #I DONT KNOW IF COMBINATION IS THE RIGHT SOLUTION, BUT ALL OF THESE POST REQUEST RETURNS 201#Created (According to Insonomia Rest Client)
        start_route = combination[0]
        end_route   = combination[1]

        routes << build_new_route_data(
          {
            node_name: start_route[1],
            time: start_route[3],
          },
          {
            node_name: end_route[1],
            time: end_route[3],
          }
        )
      end

      routes
    end
  end
end
