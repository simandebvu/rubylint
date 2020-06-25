require_relative './spec_tests/termination.rb'
require_relative './spec_tests/spaces.rb'
require_relative '../lib/filereader.rb'
require_relative '../lib/lint_logic.rb'

describe LintLogic do
  include LintLogic
  let(:control_file) { 'spec/spec_tests/control_class.rb' }
  let(:control_file_buffer) { FileReader.new(control_file) }

  describe '#check_line_length' do
    let(:test_file) { 'spec/spec_tests/line_length.rb' }
    let(:file_buffer) { FileReader.new(test_file) }
    it 'Must advise user on long lines greater than 80.' do
      expect(check_line_length(file_buffer.file_contents)).to output('Line length error. Line : 2.')
    end
  end

  describe '#check_termination' do
    let(:test_file) { 'spec/spec_tests/termination.rb' }
    let(:file_buffer) { FileReader.new(test_file) }
    it 'Must advise user on unnecessary termination colon.' do
      expect(check_termination(file_buffer.file_contents)).to eql({ 0 => "Unnecessary character ';'" })
    end

    it 'Must work normally if no errors.' do
        expect(logic_class.check_termination(control_file_buffer.file_contents)).to eql({ 0 => "Unnecessary character ';'" })
    end
  end

  describe '#check_row_spacing' do
    let(:test_file) { 'spec/spec_tests/spaces.rb' }
    let(:file_buffer) { FileReader.new(test_file) }
    it 'Must check spaces around operators.' do
      expect(logic_class.check_row_spacing(file_buffer.file_contents)).to eql({ 4 => 'Two or more empty lines' })
    end
  end

  describe '#check_num_classes' do
    let(:test_file) { 'spec/spec_tests/many_classes.rb' }
    let(:file_buffer) { FileReader.new(test_file) }
    it 'Must alert user of more than 1 class.' do
      expect(logic_class.check_num_classes(file_buffer.file_contents)).to eql({ 'classes' => 'Too many classes.' })
    end
  end
end
