require_relative "./spec_tests/indentation-wrong.rb"
require_relative "./spec_tests/termination.rb"
require_relative "./spec_tests/spaces.rb"

describe "#indentation" do
    let(:test_file){'./spec_tests/indentation-wrong.rb'}
    let(:file_buffer){ Buffer.new(test_file)}
    it "Must correctly detect wrong indentation." do
        expect(indentation?(test_file)).to eql(false)
    end
end

describe "#termination" do 
    let(:test_file){'./spec_tests/termination.rb'}
    let(:file_buffer){ Buffer.new(test_file)}
    it "Must advise user on unnecessary termination colon." do
        expect(termination?(test_file)).to eql(false)
    end
end

describe "#checkspaces" do 
    let(:test_file){'./spec_tests/spaces.rb'}
    let(:file_buffer){ Buffer.new(test_file)} 
    it "Must check spaces around operators." do
        expect(spaces?(test_file)).to eql(false)
    end   
end