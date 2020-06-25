class LintLogic
    $errors_found = Hash.new

    def check_line_length(content)
        content.each_with_index do |stringScan,idx|
            line = stringScan.string.strip!
            next if line.nil? || stringScan.nil? 
            if line.length > 80 
                $errors_found["Line length"] = idx
            end 
        end
        return $errors_found
    end

    def check_termination(content)
        filter_criteria = ["Unnecessary character ';'"]
        content.each_with_index do |stringScan,idx|  
            next if stringScan.nil?
            if stringScan.exist?(/;/)
                $errors_found[idx] = "Unnecessary character ';'"  
            end            
        end
        return $errors_found.select{|k, v| filter_criteria.include?(v) }
    end

    def check_row_spacing(content)
        filter_criteria = ["Two or more empty lines"]
        content.each_with_index do |stringScan,idx|
            next if stringScan.nil?
            if stringScan.scan(/\n/)
                if content[idx+1].scan(/\n/)
                    # p "Two lines at #{idx+1}"
                    $errors_found[idx] = "Two or more empty lines"
                end
            end
        end
        return $errors_found.select{|k, v| filter_criteria.include?(v) }
    end

    def check_num_classes(content)
        class_count = 0
        content.each_with_index do |stringScan,idx| 
            next if stringScan.nil?
            m = stringScan.exist?(/class/)
            class_count += 1 unless m.nil?
        end
        p "Aim to have just a single class/module per source file."
    end

    
    
    def log_error(type, line)
        puts "#{type} error. Line : #{line}."
    end

end
