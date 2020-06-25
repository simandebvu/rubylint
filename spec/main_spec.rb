require_relative "./spec_tests/indentation-wrong.rb"
require_relative "./spec_tests/termination.rb"
require_relative "./spec_tests/spaces.rb"
require_relative "../lib/filereader.rb"
require_relative "../lib/lint_logic.rb"

# describe "#get_indentation" do
#     let(:test_file){'spec/spec_tests/indentation-wrong.rb'}
#     let(:file_scanned){ FileReader.new(test_file)}
#     let(:logic_class){ LintLogic.new}
#     it "Must correctly detect wrong indentation." do
#         expect(logic_class.get_indentation(file_scanned.file_contents)            
#         ).to eql({'Indentation'=>2})
#     end
# end
describe LintLogic do
    let(:logic_class){ LintLogic.new}
    describe "#get_line_length" do 
        let(:test_file){'spec/spec_tests/line_length.rb'}
        let(:file_buffer){ FileReader.new(test_file)}
        it "Must advise user on long lines greater than 80." do
            expect(logic_class.get_line_length(file_buffer.file_contents)).to eql({"Line length"=>2})
        end
    end

    describe "#look_for_termination" do 
        let(:test_file){'spec/spec_tests/termination.rb'}
        let(:file_buffer){ FileReader.new(test_file)}
        it "Must advise user on unnecessary termination colon." do
            expect(logic_class.look_for_termination(file_buffer.file_contents)).to eql({0=>"Unnecessary character", 2=>"Unnecessary character"})
        end
    end

describe "#checkspaces" do 
    let(:test_file){'./spec_tests/spaces.rb'}
    let(:file_buffer){ FileReader.new(test_file)} 
    it "Must check spaces around operators." do
        expect(spaces?(test_file)).to eql(false)
    end   
end
end