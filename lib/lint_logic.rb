class LintLogic
    $errors_found = Hash.new
    KeywordExpStarters = [
        /^module\b/,
        /^class\b/,
        /^if\b/,
        /(=\s*|^)until\b/,
        /(=\s*|^)for\b/,
        /^unless\b/,
        /def/,
        /\bdo\b/,
        /^else\b/,
        /^elsif\b/,
        /\bwhen\b/,
        /\{[^\}]*$/,
        /\[[^\]]*$/
     ]

     KeywordExpClosers = [
        /^rescue\b/,
        /^ensure\b/,
        /^elsif\b/,
        /^end\b/,
        /end/,
        /^else\b/,
        /\bwhen\b/,
        /^[^\{]*\}/,
        /^[^\[]*\]/
     ]

    def get_line_length(content)
        content.each_with_index do |stringScan,idx|
            line = stringScan.string.strip!
            next if line.nil? || stringScan.nil? 
            if line.length > 80 
                $errors_found["Line length"] = idx
            end 
        end
        return $errors_found
    end

    def look_for_termination(content)
        filter_criteria = ["Unnecessary character"]
        content.each_with_index do |stringScan,idx|  
            next if stringScan.nil?
            if stringScan.exist?(/;/)
                $errors_found[idx] = "Unnecessary character"  
            end            
        end
        return $errors_found.select{|k, v| filter_criteria.include?(v) }
    end

    def get_indentation(content)
        lines_to_check = {}
        check_indentation_level(content)
        content.each_with_index do |stringScan,idx| 
            spaces = stringScan.scan(/\s+/)
            next unless !spaces.nil?
            if spaces.length > 2
                lines_to_check['Indentation'] = idx + 1
            end  
        end
        return lines_to_check
    end

    def check_indentation_level(content)
        levels = []
        level = 0
        content.each_with_index do |stringScan, idx|
            stringScan.reset
            levels << level
            KeywordExpStarters.each_with_index do |re, idx|
                next unless !stringScan.nil?
                level += 1 if stringScan.exist?(re)
                p idx
                next unless stringScan.exist?(KeywordExpClosers[idx])
                level -= 1
                levels[i] = level
            end
      
            # levels << level
            # stringScan.reset
            # KeywordExpStarters.each do |re|
            #     s = stringScan.scan_until(re)
            #     next unless !s.nil?
            #     u = stringScan.string()
            #     p u
            #     level += 1 
            #     KeywordExpClosers.each do |r|
            #         u = stringScan.string()
            #         y = stringScan.scan_until(r)
            #         p u
            #         next unless !y.nil?
            #         level -= 1 
            #     end
            #     break
            # end
        end
        p levels
        return levels
    end

    def log_error(type, line)
        puts "#{type} error. Line : #{line}."
    end

end
