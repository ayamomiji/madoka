require 'active_model'
require 'active_model/model' unless defined?(ActiveModel::Model)
require 'active_record/attribute_assignment'
require 'active_record/errors'

module Madoka
  module SerializableModel
    extend ActiveSupport::Concern

    included do
      include ActiveModel::Model
      include ActiveModel::Serializers::JSON
      self.include_root_in_json = false
    end
  end
end
