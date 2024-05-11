# frozen_string_literal: true

require 'echo_craft/service_objects/query'

module ServiCraft
  # Query Record Service
  class Query
    def initialize(base, page: 1, rows: nil)
      @base = base
      @page = page.to_i
      @rows = rows
      @response = ::EchoCraft::ServiceObjects::Query.new(query: @base, page: @page, rows: @rows)
    end

    def call
      @response.list(paginate(@base))
      @response
    rescue StandardError => e
      puts "#{e.class}: #{e.message}"
      puts e.backtrace.join("\n")
    end

    private

    def paginate(query)
      return query if @rows.nil?

      return paginate_array(query) if query.instance_of? Array

      paginate_active_record(query)
    end

    def paginate_active_record(query)
      rows = @rows.to_i
      page = @page.to_i
      query.limit(rows).offset(rows * (page - 1))
    end

    def paginate_array(query)
      rows = @rows.to_i
      page = @page.to_i
      query.drop(rows * (page - 1)).take(rows)
    end
  end
end
