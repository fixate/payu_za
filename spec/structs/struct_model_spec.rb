require 'spec_helper'

RSpec.describe PayuZa::Structs::StructModel do
  before do
    class DummyClass
      include PayuZa::Structs::StructModel

      field :name, required: true
      field :email, required: true
      field :description, default: 'Foo Bar'
      field :mobile, default: '1234', required: true # Just for test purposes
    end
  end

  subject { DummyClass.new }

  describe '.create' do
    it 'allows mass assignment' do
      message = DummyClass.create(name: 'Fooman', email: 'foo@bar.com')
      expect(message.name).to eq('Fooman')
      expect(message.email).to eq('foo@bar.com')
    end
  end

  describe '.field' do
    before { subject.class.field :test, default: 'hello' }

    it 'creates a reader' do
      expect(subject).to respond_to(:test)
    end

    it 'creates a writer' do
      expect(subject).to respond_to(:test=)
    end

    it 'uses default if nil' do
      subject.test = 'world'
      subject.test = nil
      expect(subject.test).to eq('hello')
    end

    it 'uses value if present' do
      subject.test = 'world'
      expect(subject.test).to eq('world')
    end
  end

  describe '#to_hash' do
    it 'has the class name as root' do
      expect(subject.to_hash).to have_key('DummyClass')
    end

    it 'uses overriden root name' do
      old_root = subject.class.root
      subject.class.root "FooRoot"
      expect(subject.to_hash).to have_key('FooRoot')
      subject.class.root(old_root)
    end

    it 'contains all the non-nil fields' do
      expect(subject.to_hash['DummyClass']).to have_key('description')
    end

    it 'converts nested structs' do
      subject.class.field :another_dummy
      subject.another_dummy = DummyClass.create(name: 'nested')
      expect(subject.to_hash['DummyClass']['another_dummy']['name']).to eq('nested')
    end
  end

  describe '#valid?' do
    it 'is not valid when required fields are empty' do
      subject.name = 'blah'
      expect(subject).to_not be_valid
    end

    it 'is valid when all required fields are complete' do
      subject.name = 'blah'
      subject.email = 'foo'
      expect(subject).to be_valid
    end
  end

  describe '#validate!' do
    it 'raises error when required fields are empty' do
      subject.name = 'blah'
      expect {
        subject.validate!
      }.to raise_error(PayuZa::StructNotValidError)
    end

    it 'doesnt raise error when all required fields are complete' do
      subject.name = 'blah'
      subject.email = 'foo'
      expect {
        subject.validate!
      }.to_not raise_error
    end
  end
end
