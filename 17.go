package main

import (
  "fmt"
  "strings"
  "unicode"
)

func is_valid_char(c rune) bool {
  return unicode.IsLower(c) || unicode.IsDigit(c) || c == '.'
}

func is_valid_username(username string) bool {
  if len(username) < 6 || len(username) > 30 {
    fmt.Fprintln(os.Stderr, "Ошибка: Имя пользователя должно быть от 6 до 30 символов.")
    return false
  }
  
  if username[0] == '.' || username[len(username)-1] == '.' {
    fmt.Fprintln(os.Stderr, "Ошибка: Имя пользователя не может начинаться или заканчиваться точкой.")
    return false
  }
  
  prev_is_dot := false
  for _, c := range username {
    if !is_valid_char(c) {
      fmt.Fprintf(os.Stderr, "Ошибка: Недопустимый символ '%c' в имени пользователя.\n", c)
      return false
    }
    
    if c == '.' {
      if prev_is_dot {
        fmt.Fprintln(os.Stderr, "Ошибка: Не может быть двух точек подряд.")
        return false
      }
      prev_is_dot = true
    } else {
      prev_is_dot = false
    }
  }
  
  return true
}

func process_email(email string) string {
  at_pos := strings.Index(email, "@")
  if at_pos == -1 {
    fmt.Fprintln(os.Stderr, "Ошибка: Отсутствует символ '@' в email.")
    return ""
  }
  
  username := strings.ToLower(email[:at_pos])
  domain := email[at_pos:]
  
  if plus_pos := strings.Index(username, "+"); plus_pos != -1 {
    username = username[:plus_pos]
  }
  
  if !is_valid_username(username) {
    return ""
  }
  
  return username + domain
}

func main() {
  unique_emails := make(map[string]bool)
  fmt.Println("Введите email-адреса через запятую: ")
  
  var input string
  fmt.Scanln(&input)
  
  for _, raw_email := range strings.Split(input, ",") {
    email := strings.TrimSpace(raw_email)
    if email != "" {
      processed := process_email(email)
      if processed != "" {
        unique_emails[processed] = true
      }
    }
  }
  
  fmt.Printf("Количество уникальных адресов: %d\n", len(unique_emails))
}
