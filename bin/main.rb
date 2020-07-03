#!/usr/bin/env ruby
require_relative '../lib/filereader.rb'
require_relative '../lib/lint_logic.rb'
require_relative '../lib/string.rb'

class RubyLint
  include LintLogic

  @file_buffer = nil

  def initialize(file_path)
    puts 'Welcome to Ruby Lint!'.green
    @file_path = file_path
    @file_buffer = FileReader.new(@file_path)
    lines = @file_buffer.file_contents.length
    puts "Scanned #{lines} lines in the file."
    check_line_length(@file_buffer.file_contents)
    check_termination(@file_buffer.file_contents)
    check_row_spacing(@file_buffer.file_contents)
    check_num_classes(@file_buffer.file_contents)
    check_indentation(@file_buffer.file_contents)
  end
end

file_path = ARGV.shift
RubyLint.new(file_path) unless file_path.nil?
