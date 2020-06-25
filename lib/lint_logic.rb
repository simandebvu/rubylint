module LintLogic
  attr_accessor :errors_found

  def check_line_length(content)
    content.each_with_index do |string_scan, index|
      # p "1. START LINE"
      # p string_scan
      has_text = string_scan.scan_until(/\w+/)
      # p "Has Test"
      next if has_text.nil?
      # p has_text
      line = string_scan.string()
      # p line.length #BHOOO
      log_error('Line length', index) if line.length > 80
      # p "LOOP CLOSES."
    end
    # p "CONTENT END."
    # puts "Line Check Scan Complete"
  end

  def check_termination(content)
    filter_criteria = ["Unnecessary character ';'"]
    content.each_with_index do |string_scan, index|
      next if string_scan.nil? || !string_scan.exist?(/;/)
      @errors_found[index] = "Unnecessary character ';'" 
    end
    @errors_found.select { |_k, v| filter_criteria.include?(v) } unless !flagged
  end

  def check_row_spacing(content)
    filter_criteria = ['Two or more empty lines']
    content.each_with_index do |string_scan, index|
      next if string_scan.nil?

      next unless string_scan.scan(/\n/)

      @errors_found[index] = 'Two or more empty lines' if content[index + 1].scan(/\n/)
    end
    @errors_found.select { |_k, v| filter_criteria.include?(v) }
  end

  def check_num_classes(content)
    filter_criteria = ['classes']
    class_count = 0
    content.each_with_index do |string_scan, _index|
      next if string_scan.nil?

      m = string_scan.exist?(/class/)
      class_count += 1 unless m.nil?
    end
    @errors_found['classes'] = 'Too many classes.'
    @errors_found.select { |key, _v| filter_criteria.include?(key) }
  end

  def log_error(type, line)
    puts "#{type} error. Line : #{line}."
  end
end
