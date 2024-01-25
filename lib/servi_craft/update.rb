# frozen_string_literal: true

require 'echo_craft/service_objects/update'
module ServiCraft
  # UpdateRecordService
  class Update

    attr_reader :model, :record, :params, :response

    def initialize(record, params)
      @record = record
      @model = @record.class
      @params = params
      @response = ::EchoCraft::ServiceObjects::Update.new(@record, @params)
    end

    def call(before_assign_attributes: proc {},
             before_update: proc {},
             after_successful_update: proc {},
             after_failed_update: proc {},
             finally: proc {})

      begin
        before_assign_attributes.call

        @record.assign_attributes(@params)

        before_update.call

        process_record_update @record.save, after_successful_update:, after_failed_update:
      rescue StandardError
        fail_update(after_failed_update:)
      end
      finally.call
      @response
    end

    private

    def process_record_update(result, after_successful_update: proc {},
                              after_failed_update: proc {})
      if result
        after_successful_update.call
        @response.updated
      else
        fail_update(after_failed_update:)
      end
      result
    end

    def fail_update(after_failed_update: proc {})
      after_failed_update.call
      @response.unprocessabled
    end
  end
end
