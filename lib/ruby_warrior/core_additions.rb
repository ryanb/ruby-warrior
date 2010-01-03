class String
  def camelize
    gsub(/(?:^|_)(.)/) { $1.upcase }
  end
  
  def constantize
    unless /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/ =~ self
      raise NameError, "#{camel_cased_word.inspect} is not a valid constant name!"
    end
    
    Object.module_eval("::#{$1}", __FILE__, __LINE__)
  end
  
  def underscore
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').gsub(/([a-z\d])([A-Z])/,'\1_\2').tr("-", "_").downcase
  end
  
  def humanize
    gsub(/_/, " ").capitalize
  end

  def titleize
    underscore.humanize.gsub(/\b('?[a-z])/) { $1.capitalize }
  end
  
  def hard_wrap(width = 80)
    gsub(/(.{1,#{width}})(\s+|$)/, "\\1\n").strip
  end
end
