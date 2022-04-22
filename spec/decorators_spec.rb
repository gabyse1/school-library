require_relative '../decorators/nameable'
require_relative '../classes/person'
require_relative '../decorators/decorator'
require_relative '../decorators/capitalize_decorator'
require_relative '../decorators/trimmer_decorator'

describe Decorator do
  before :all do
    @person = Person.new(20, name: 'Fabrizio Microverse')
  end

  context '#Without decorator' do
    it 'should return the same person&apos;s name' do
      expect(@person.correct_name).to eql 'Fabrizio Microverse'
    end
  end

  context '#Capitalize' do
    it 'should be an instance of CapitalizeDecorator' do
      cap_decor_name = CapitalizeDecorator.new(@person)
      expect(cap_decor_name).to be_an_instance_of CapitalizeDecorator
    end

    it 'should return the capitalize person&apos;s name' do
      cap_decor_name = CapitalizeDecorator.new(@person)
      expect(cap_decor_name.correct_name).to eql 'FABRIZIO MICROVERSE'
    end
  end

  context '#Trimmer' do
    it 'should be an instance of TrimmerDecorator' do
      trim_decor_name = TrimmerDecorator.new(@person)
      expect(trim_decor_name).to be_an_instance_of TrimmerDecorator
    end

    it 'should return the trimmed person&apos;s name of max 10 characters' do
      trim_decor_name = TrimmerDecorator.new(@person)
      expect(trim_decor_name.correct_name).to eql 'Fabrizio M'
    end
  end

  context '#Capitalize&Trimmer' do
    it 'should return the capitalize and trimmed person&apos;s name of max 10 characters' do
      cap_decor_name = CapitalizeDecorator.new(@person)
      expect(cap_decor_name.correct_name).to eql 'FABRIZIO MICROVERSE'
      trim_decor_name = TrimmerDecorator.new(cap_decor_name)
      expect(trim_decor_name.correct_name).to eql 'FABRIZIO M'
    end
  end
end
