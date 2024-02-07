# frozen_string_literal: true

require 'echo_craft/service_objects/create'

module ServiCraft
  # CreateRecordService
  class Create
    attr_reader :model, :record, :params, :response

    def initialize(model, params)
      @model = model
      @params = params
      @response = ::EchoCraft::ServiceObjects::Create.new(@params)
    end

    def call(before_assign_attributes: proc {},
             before_create: proc {},
             after_successful_create: proc {},
             after_failed_create: proc {},
             finally: proc {})
      begin
        before_assign_attributes.call
        @record = @model.new(@params)
        before_create.call
        process_record_create(@record.save, after_successful_create: after_successful_create, after_failed_create: after_failed_create)
      rescue StandardError
        fail_create(after_failed_create: after_failed_create)
      end
      finally.call
      @response
    end

    private

    def process_record_create(result, after_successful_create: proc {}, after_failed_create: proc {})
      if result
        after_successful_create.call
        @response.created(@record)
      else
        fail_create(after_failed_create: after_failed_create)
      end
    end

    def fail_create(after_failed_create: proc {})
      after_failed_create.call
      @response.unprocessabled(@record)
    end
  end
end
