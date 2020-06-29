require 'strscan'
class FileReader
  attr_reader :file_contents
  def initialize(file)
    @file = file
    @file_contents = read_file
    @num_lines = @file_contents.size
  end

  private

  def read_file
    file_ = nil
    File.open(@file, 'r') { |n| file_ = n.readlines }
    file_.map! { |s| StringScanner.new(s) }
    file_
  end
end

