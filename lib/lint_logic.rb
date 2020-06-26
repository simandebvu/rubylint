module LintLogic
  attr_accessor :errors_found

  def check_line_length(content)
    content.each_with_index do |string_scan, index|
      has_text = string_scan.scan_until(/\w+/)
      next if has_text.nil?

      line = string_scan.string
      next if line.nil?

      log_error('Line length', index + 1) if line.length > 80
    end
  end

  def check_termination(content)
    content.each_with_index do |string_scan, index|
      has_text = string_scan.scan_until(/;/)
      next if has_text.nil? || string_scan.nil?

      log_error("Unnecessary character ';'", index + 1)
    end
  end

  def check_row_spacing(content)
    content.each_with_index do |string_scan, index|
      next if string_scan.nil?
      next unless string_scan.scan(/\n/)

      if index < content.size
        next_line = content[index + 1].scan(/\n/)
        log_error('Two or more empty lines', index + 1) unless next_line.nil?
      end
    end
  end

  def check_num_classes(content)
    class_count = 0
    content.each_with_index do |string_scan, _index|
      next if string_scan.nil?

      m = string_scan.exist?(/class/)
      class_count += 1 unless m.nil?
    end
    log_error('Classes ', '<Whole File>') unless class_count <= 1
  end

  def log_error(type, line)
    puts "#{type} error. Line : #{line}."
  end
end
