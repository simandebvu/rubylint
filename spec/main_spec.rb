require_relative './spec_tests/termination.rb'
require_relative './spec_tests/spaces.rb'
require_relative '../lib/filereader.rb'
require_relative '../lib/lint_logic.rb'

describe LintLogic do
  let(:logic_class) { LintLogic.new }
  describe '#check_line_length' do
    let(:test_file) { 'spec/spec_tests/line_length.rb' }
    let(:file_buffer) { FileReader.new(test_file) }
    it 'Must advise user on long lines greater than 80.' do
      expect(logic_class.check_line_length(file_buffer.file_contents)).to eql({ 'Line length' => 2 })
    end
  end

  describe '#check_termination' do
    let(:test_file) { 'spec/spec_tests/termination.rb' }
    let(:file_buffer) { FileReader.new(test_file) }
    it 'Must advise user on unnecessary termination colon.' do
      expect(logic_class.check_termination(file_buffer.file_contents)).to eql({ 0 => "Unnecessary character ';'" })
    end
  end

  describe '#check_row_spacing' do
    let(:test_file) { 'spec/spec_tests/spaces.rb' }
    let(:file_buffer) { FileReader.new(test_file) }
    it 'Must check spaces around operators.' do
      expect(logic_class.check_row_spacing(file_buffer.file_contents)).to eql({ 4 => 'Two or more empty lines' })
    end
  end
end
