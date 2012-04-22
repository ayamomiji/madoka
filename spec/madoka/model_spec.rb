require 'spec_helper'

class MadokaModel
  include Madoka::Model
  attr_accessor :accessible_by_default, :protected_by_default
  attr_accessor :accessible_by_admin
  attr_accessible :accessible_by_default
  attr_protected :protected_by_default
  attr_accessible :accessible_by_admin, as: :admin

  attr_accessor :flow

  before_save :run_before_save
  after_save :run_after_save

  def run_before_save
    @flow = [:before_save]
  end

  def run_after_save
    @flow << :after_save
  end
end

describe MadokaModel do
  it_behaves_like 'ActiveModel'
  it { should     allow_mass_assignment_of(:accessible_by_default) }
  it { should_not allow_mass_assignment_of(:protected_by_default) }
  it { should_not allow_mass_assignment_of(:accessible_by_admin) }
  it { should_not allow_mass_assignment_of(:accessible_by_default).as(:admin) }
  it { should_not allow_mass_assignment_of(:protected_by_default).as(:admin) }
  it { should     allow_mass_assignment_of(:accessible_by_admin).as(:admin) }

  describe '#save' do
    context 'when valid' do
      before { stub(subject).valid? { true } }
      it { subject.should be_true }
    end

    context 'when invalid' do
      before { stub(subject).valid? { false } }
      it { subject.save.should be_false }
    end

    it 'should run callback' do
      subject.save
      subject.flow.should == [:before_save, :after_save]
    end
  end

  describe '#save!' do
    context 'when valid' do
      before { stub(subject).valid? { true } }
      it { lambda { subject.save! }.should_not raise_error }
    end

    context 'when invalid' do
      before { stub(subject).valid? { false } }
      it { lambda { subject.save! }.should raise_error(Madoka::ModelInvalid) }
    end

    it 'should run callback' do
      subject.save!
      subject.flow.should == [:before_save, :after_save]
    end
  end

  describe '#initialize' do
    context 'when no args' do
      it 'should not do assignment' do
        any_instance_of(MadokaModel) do |model|
          dont_allow(model).assign_attributes
        end
        MadokaModel.new
      end
    end

    context 'when with params' do
      it 'should assign attributes' do
        attrs = {accessible_by_default: 'hello'}
        any_instance_of(MadokaModel) do |model|
          stub(model).assign_attributes(attrs, {})
        end
        MadokaModel.new(attrs)
      end
    end
  end
end
