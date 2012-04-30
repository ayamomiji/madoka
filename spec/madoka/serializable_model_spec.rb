require 'spec_helper'

class MadokaSerializableModel
  include Madoka::SerializableModel

  def serializable_hash(options = nil)
    {'attribute' => 'value'}
  end
end

describe MadokaSerializableModel do
  describe '#to_json' do
    it 'should convert to json string' do
      MadokaSerializableModel.new.to_json.
        should == {'attribute' => 'value'}.to_json
    end
  end
end
