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
    end

    private

    def paginate(query)
      return query if @rows.nil?

      rows = @rows.to_i
      page = @page.to_i
      query.limit(rows).offset(rows * (page - 1))
    end
  end
end
