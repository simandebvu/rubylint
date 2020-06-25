class LintLogic
  attr_accessor :errors_found

  @errors_found = nil

  def initialize
    @errors_found = {}
  end

  def check_line_length(content)
    content.each_with_index do |string_scan, index|
      line = string_scan.string.strip!
      next if line.nil? || string_scan.nil?

      @errors_found['Line length'] = index if line.length > 80
    end
    @errors_found
  end

  def check_termination(content)
    filter_criteria = ["Unnecessary character ';'"]
    content.each_with_index do |string_scan, index|
      next if string_scan.nil?

      @errors_found[index] = "Unnecessary character ';'" if string_scan.exist?(/;/)
    end
    @errors_found.select { |_k, v| filter_criteria.include?(v) }
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
