module LintLogic
  attr_accessor :errors_found

  def check_line_length(content)
    content.each_with_index do |string_scan, index|
      string_scan.reset
      has_text = string_scan.scan_until(/\w+/)
      next if has_text.nil?

      line = string_scan.string
      next if line.nil?

      log_error('Line length', index + 1) if line.length > 80
    end
  end

  def check_termination(content)
    content.each_with_index do |string_scan, index|
      string_scan.reset
      has_text = string_scan.scan_until(/;/)
      next if has_text.nil? || string_scan.nil?

      log_error("Unnecessary character ';'", index + 1)
    end
  end

  def check_row_spacing(content)
    content.each_with_index do |string_scan, index|
      string_scan.reset
      first = string_scan.string.strip
      next unless first.length.zero?

      v = content[index + 1].string.strip
      log_error('Two or more empty lines', index + 1) if v.length.zero?
    end
  end

  def check_num_classes(content)
    class_count = 0
    content.each_with_index do |string_scan, index|
      string_scan.reset
      m = string_scan.match?('class')
      next if m.nil?

      class_count += 1
      log_error('Classes ', index) unless class_count == 1
    end
  end

  private

  def log_error(type, line)
    puts "#{type} error. Line : #{line}."
  end
end
