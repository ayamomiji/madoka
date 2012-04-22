module Madoka
  class ModelInvalid < StandardError
    attr_reader :model
    def initialize(model)
      @model = model
      errors = @model.errors.full_messages.join(", ")
      super(I18n.t("activerecord.errors.messages.record_invalid", :errors => errors))
    end
  end
end
