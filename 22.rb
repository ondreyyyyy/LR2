def is_valid_char(c)
  c.match?(/[a-z0-9.]/)
end

def is_valid_username(username)
  if username.length < 6 || username.length > 30
    STDERR.puts "Ошибка: Имя пользователя должно быть от 6 до 30 символов."
    return false
  end
  
  if username[0] == '.' || username[-1] == '.'
    STDERR.puts "Ошибка: Имя пользователя не может начинаться или заканчиваться точкой."
    return false
  end
  
  prev_is_dot = false
  username.each_char do |c|
    unless is_valid_char(c)
      STDERR.puts "Ошибка: Недопустимый символ '#{c}' в имени пользователя."
      return false
    end
    
    if c == '.'
      if prev_is_dot
        STDERR.puts "Ошибка: Не может быть двух точек подряд."
        return false
      end
      prev_is_dot = true
    else
      prev_is_dot = false
    end
  end
  
  true
end

def process_email(email)
  at_pos = email.index('@')
  unless at_pos
    STDERR.puts "Ошибка: Отсутствует символ '@' в email."
    return ""
  end
  
  username = email[0...at_pos].downcase
  domain = email[at_pos..-1]
  
  if plus_pos = username.index('+')
    username = username[0...plus_pos]
  end
  
  unless is_valid_username(username)
    return ""
  end
  
  username + domain
end

unique_emails = Set.new
print "Введите email-адреса через запятую: "
input = gets.chomp

input.split(',').each do |raw_email|
  email = raw_email.strip
  unless email.empty?
    processed = process_email(email)
    unique_emails.add(processed) unless processed.empty?
  end
end

puts "Количество уникальных адресов: #{unique_emails.size}"
