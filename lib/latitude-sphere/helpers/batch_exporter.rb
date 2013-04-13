require 'sinatra/base'
require 'date'

module Sinatra
  module BatchExporter
    module Helper
      def batch_export(method, start_date, end_date, options = {})
        batch = Google::APIClient::BatchRequest.new

        start_date = Date.parse(start_date)
        end_date   = Date.parse(end_date)

        start_date.upto(end_date) do |date|
          batch_options = {
            :api_method  => method,
            :body_object => { 'longUrl' => 'http://example.com/foo' }
          }

          batch.add(batch_options) { |result| export_to_disk(date, response) }
        end
        batch
      end

      def export_to_disk(date, response)
        # TODO: write result to disk
      end
    end


    def self.registered(app)
      app.helpers BatchExporter::Helpers
    end
  end

  register BatchExporter
end