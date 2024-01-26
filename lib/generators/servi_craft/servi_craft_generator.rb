# frozen_string_literal: true

require 'model_ancestry/base'
# init base service Objects
class ServiCraftGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  argument :attributes, type: :array, default: [], banner: 'field:type field:type'

  class_option :services, type: :array, default: %w[create update destroy query]
  class_option :parent_attribute, type: :string

  def gen_init
    assign_service_params
    options.services.each { |service| init service }
  end

  private

  def assign_service_params
    set_parent_attribute if options.parent_attribute
    set_service_class_path
    set_service_dir
    @service_module = @service_class_path.map(&:camelcase).join('::')
    set_service_model
  end

  def set_parent_attribute
    @parent_attribute = ::ModelAncestry::Base.find_parent(attributes, options.parent_attribute)
  end

  def set_service_class_path
    plural_name = name.pluralize
    @service_class_path = plural_name.include?('/') ? plural_name.split('/') : plural_name.split('::')
    @service_class_path.map!(&:underscore)
  end

  def set_service_dir
    @service_dir = @service_class_path.join('/')
    @service_dir = ['app', 'services', @service_class_path].flatten.compact.join('/')
  end

  def set_service_model
    @service_model = @service_class_path.map(&:camelcase)
    @service_model[-1] = file_name.camelcase
    @service_model = "::#{@service_model.join('::')}"
  end

  def init(service)
    type = service.underscore.split('_').first
    type = 'info' unless defined_services.include? type

    @service_class_name = service.camelize
    template "#{type}.template", "#{@service_dir}/#{service}.rb"
  end

  def defined_services
    %w[create update destroy query info]
  end
end
