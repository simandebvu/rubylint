#!/usr/bin/env ruby
require_relative '../lib/filereader.rb'
require_relative '../lib/lint_logic.rb'

class RubyLint
  include LintLogic

  @file_buffer = nil

  def initialize(file_path)
    puts 'Welcome to Ruby Lint!'
    @file_path = file_path
    @file_buffer = FileReader.new(@file_path)
    check_line_length(@file_buffer.file_contents)
    check_termination(@file_buffer.file_contents)
    check_row_spacing(@file_buffer.file_contents)
    check_num_classes(@file_buffer.file_contents)
    show_errors(@errors_found) unless @errors_found.size <= 0
  end

  def show_errors(_errors_hash)
    puts 'Errors Listing'
  end
end

file_path = ARGV.shift
RubyLint.new(file_path) unless file_path.nil?
