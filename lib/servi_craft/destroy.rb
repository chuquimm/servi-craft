# frozen_string_literal: true

require 'echo_craft/service_objects/destroy'

module ServiCraft
  # Destroy Record Service
  class Destroy

    def initialize(record)
      @record = record
      @response = ::EchoCraft::ServiceObjects::Destroy.new(@record)
    end

    def call(before_destroy: proc {},
             after_successful_destroy: proc {},
             after_failed_destroy: proc {},
             finally: proc {})

      before_destroy.call
      process_record_destroy(after_successful_destroy:, after_failed_destroy:)
      finally.call

      @response
    end

    private

    def process_record_destroy(after_successful_destroy: proc {},
                               after_failed_destroy: proc {})

      @record.destroy
      after_successful_destroy.call

      @response.destroyed
    rescue ActiveRecord::InvalidForeignKey => e
      @record.errors.add(:base, :fk_constraint, message: e.cause.message)
      unprocessabled_destroy(after_failed_destroy:)
    rescue StandardError
      unprocessabled_destroy(after_failed_destroy:)
    end

    def unprocessabled_destroy(after_failed_destroy: proc {})
      after_failed_destroy.call
      @response.unprocessabled
    end
  end
end
