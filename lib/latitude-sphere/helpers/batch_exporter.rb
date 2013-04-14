require 'sinatra/base'
require 'multi_json'
require 'date'

module Sinatra
  module BatchExporter
    module Helpers
      extend self

      def batch_export(options = {})
        batch = Google::APIClient::BatchRequest.new

        max_date = Date.parse(options[:max_time])
        min_date = Date.parse(options[:min_time])

        min_date.upto(max_date) do |date|
          batch_options = {
            :api_method  => options[:api_method],
            :body_object => {
              'max-results' => 1000,
              'granularity' => 'best',
              'min-time' => date.to_time.to_i,
              'max-time' => date.next.to_time.to_i
            }
          }

          batch.add(batch_options) do |result|
            export_to_disk(date, MultiJson.load(result.response.body), options[:email])
          end
        end
        batch
      end

      def export_to_disk(date, data, email)
        root_folder_name  = email.gsub(/[\.@]/, '_')
        create_dir root_folder_name

        year_folder_name  = File.join(root_folder_name, date.year.to_s)
        create_dir year_folder_name

        month_folder_name = File.join(year_folder_name, date.mon.to_s)
        create_dir month_folder_name

        file_path         = File.join(month_folder_name, date.to_s)

        write(file_path, MultiJson.dump(data, :pretty => true))
      end

      private

      def create_dir(path)
        Dir.mkdir(path) unless Dir.exist?(path)
      end

      def write(file_path, content)
        File.open(file_path, 'w') { |f| f.write(content) }
      end
    end


    def self.registered(app)
      app.helpers BatchExporter::Helpers
    end
  end

  register BatchExporter
end