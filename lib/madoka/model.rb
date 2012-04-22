require 'active_model'
require 'active_model/model' unless defined?(ActiveModel::Model)
require 'active_record/attribute_assignment'
require 'active_record/errors'

module Madoka
  module Model
    extend ActiveSupport::Concern
    include ActiveModel::Model
    include ActiveRecord::AttributeAssignment

    included do
      extend ActiveModel::Callbacks
      define_model_callbacks :save
    end

    def initialize(params = nil, options = {})
      assign_attributes(params, options.slice(:as)) if params
    end

    def save
      result = valid?
      run_callbacks(:save) { result }
    end

    def save!
      result = valid?
      run_callbacks(:save) { result or raise(ModelInvalid.new(self)) }
    end

    module ClassMethods
      protected

      # we don't have primary_key and inheritance_column...
      def attributes_protected_by_default
        []
      end
    end
  end
end
