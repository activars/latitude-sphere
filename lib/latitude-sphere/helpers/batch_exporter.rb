require 'sinatra/base'
require 'date'

module Sinatra
  module BatchExporter
    module Helpers
      extend self

      def batch_export(api_method, max_time, min_time, options = {})
        batch = Google::APIClient::BatchRequest.new

        max_date = Date.parse(max_time)
        min_date = Date.parse(min_time)

        min_date.upto(max_date) do |date|
          batch_options = {
            :api_method  => api_method,
            :body_object => {
              'max-results' => 1000,
              'granularity' => 'best',
              'min-time' => date.to_time.to_i,
              'max-time' => date.next.to_time.to_i
            }
          }

          batch.add(batch_options) { |result| export_to_disk(date, result.response) }
        end
        batch
      end

      def export_to_disk(date, response)
        # TODO: write response to disk
        puts date, response.body
      end
    end


    def self.registered(app)
      app.helpers BatchExporter::Helpers
    end
  end

  register BatchExporter
end