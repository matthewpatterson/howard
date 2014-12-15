require "time"

module Howard
  class Arrival
    def initialize(api_response)
      @api_response = api_response
    end

    def train
      @train ||= Train.new(@api_response)
    end

    def prediction_time
      Time.strptime("#{@api_response["prdt"]} America/Chicago", "%Y%m%d %H:%M:%S %Z")
    end

    def arrival_time
      Time.strptime("#{@api_response["arrT"]} America/Chicago", "%Y%m%d %H:%M:%S %Z")
    end

    def approaching?
      @api_response.fetch("isApp", "0") == "1"
    end
    alias_method :due?, :approaching?

    def scheduled?
      @api_response.fetch("isSch", "0") == "1"
    end

    def live?
      !scheduled?
    end

    def fault?
      @api_response.fetch("isFlt", "0") == "1"
    end

    def delayed?
      @api_response.fetch("isDly", "0") == "1"
    end
  end
end